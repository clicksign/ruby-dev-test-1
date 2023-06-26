#
# Classe básica para buscas da aplicação, usando Finders
#
class ApplicationSearch
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  def self.inherited(subclass)
    super
    subclass.include Finders::FinderMethodInterceptor

    # XXX: coloque aqui os "default finders", como o :sorted
    # default finders
    # ---
    subclass.finder :sorted
    # TODO: finder :text_search, requires: :q
  end

    #
    # Escopo padrão para realização da busca. Se não definido, é inferido a partir do nome da classe
    # de busca - ex: `UserSearch` -> `User.all`.
    #
    # Para customizar, defina com bloco (como no ActiveRecord):
    # ```ruby
    # default_scope { |scope| scope.where(blocked: false) }
    # ```
    #
    # @return [ActiveRecord::Relation] escopo padrão para buscas.
    #
  def self.default_scope(scope = nil, &block)
    @default_scope_customize_block = block if block_given?

    # inferido pelo nome da classe: UserSearch -> User.all
    scope ||= name.sub("Search", "").constantize.all
    scope_customize_block = @default_scope_customize_block || lambda { |scop| scop }

    scope_customize_block.call(scope)
  end

    #
    # Construtor alternativo que constrói e já realiza a busca.
    #
    # @param [Array] *args argumentos do construtor
    #
    # @return [Finders::Search] Busca, com escopo já atualizado (busca realizada)
    #
  def self.search(...)
    new(...).search
  end

  attr_reader :scope
  alias result scope

  delegate :default_scope, to: :class

    # XXX: Para permitir testes com mocks, registramos delegate para :order
    #   Ex:
    # ```
    #   expect_any_instance_of(InterestSearch).to receive(:order)
    #     .with("created_at" => "asc")
    #     .and_call_original
    # ```
  delegate :order, to: :scope

    # default attributes
    # ---

  attribute :q,    :string
  attribute :sort  # String, Array<String>, Hash<Symbol,Symbol>

  def sort=(value)
    # ao atualizar atributo sort, apague valor memoizado de #sort_attrs
    @sort_attrs = nil
    super
  end

  def initialize(scope = nil, **attributes)
    super(attributes)

    @scope = default_scope scope
  end

    #
    # Atualiza os atributos de busca.
    #
    # @param [Hash] **attributes Atributos de busca a serem atualizados
    #
    # @return [Boolean] resultado da validação de todos os atributos definidos na classe de busca
    #
  def update(**attributes)
    super

    # Após atualizar os atributos, revalidamos a busca para que o estado de
    # validação seja definido (ou atualizado).
    validate
  end

    #
    # Realiza a busca, acumulando todos os métodos finder cujos requisitos
    # estejam satisfeitos (validação).
    #
    # @return [Finders::Search] busca com escopo atualizado
    #
  def search(**attributes)
    update(attributes) if attributes.present?

    self.class.finders.each_key { |method| public_send(method) }
    self
  end

    #
    # Validação de presença de atributo usado em Finders::FinderMethodInterceptor
    #
  def valid_attr?(name, presence: true)
    # Testamos "presenca", incluindo valores booleanos.
    # Como `false.blank? == true`, temos que adicionar uma condição `!= false`.
    attr_value = send(name)
    return false if presence && attr_value != false && attr_value.blank?

    !errors.key?(name)
  end

    #
    # Realiza a ordenação conforme regras pré-estabelecidas pelo sistema.
    #
  def sorted
      # ordenação explícita
    if sort_attrs.present?
      sorted = scope.order(sort_attrs)
      sorted = sorted.order(:id) unless sort_attrs.include?("id") # XXX: critério desempate para ordenação

      sorted
    # busca textual (aplica ordenação por similaridade)
    elsif q.present?
      order(:id)  # XXX: critério desempate para ordenação
    else
      # implementação de Model original
      scope.respond_to?(:sorted) ? scope.sorted : scope
    end
  end

    #
    # Faz o parsing de parâmetros possíveis de ordenação, tratando também parâmetros de requisição.
    # processa o #sort sendo:
    # - String, como "name,price:desc"
    # - Array, como ["name", "price:desc"]
    # e transforma em uma Hash no padrão `attr_name => sort_dir`, para usar em ActiveRelation.order
    #
  def sort_attrs
    return {} if sort.blank?

    @sort_attrs ||= begin
      params = sort

      params = parse_sort_from_string_to_array(params) if params.is_a? String
      params = parse_sort_from_array_to_order(params)  if params.is_a? Array

      params
    end
  end

  def method_missing(method, *args)
    if scope.respond_to?(method)
      scope.send(method, *args)
    else
      super
    end
  end

  def respond_to_missing?(method, *args)
    scope.respond_to?(method) || super
  end

  private

  def parse_sort_from_string_to_array(sort_as_string)
    # Separa os parâmetros em itens de uma array através do padrão no Regex
    #
    # Entrada:
    # sort = "name,price:desc"
    #
    # Saída:
    # columns = ["name", "price:desc"]
    #
    sort_as_string.scan(/[a-z_]+:asc|[a-z_]+:desc|[a-z_]+/)
  end

  def parse_sort_from_array_to_order(sort_as_array)
    #
    # Entrada:
    # columns = ["name", "price:desc", "vehicleBrand.name:desc"]
    #
    # Saída:
    # columns = "name asc, price desc, vehicle_brand.name desc"
    #

    sort_as_array = sort_as_array.map do |value|
      sort_attr, sort_dir = value.split(":", 2)
      sort_dir = "asc" unless %w[asc desc].include?(sort_dir)
      sort_attr << " #{sort_dir}"

      sort_attr.underscore
    end

    sort_as_array.join(",")
  end
end
