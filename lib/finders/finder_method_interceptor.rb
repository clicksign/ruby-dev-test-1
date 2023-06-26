module Finders
  #
  # Interceptador de métodos de busca para:
  # - verificar a validação dos atributos necessários ao método de busca
  #   - em caso de serem inválidos, ignora a adição do escopo do método de busca
  # - automaticamente adicionar o escopo do método à busca como um todo,
  #   simplificando o código dos métodos de busca e permitindo "chainning"
  #
  module FinderMethodInterceptor
    INTERCEPTOR_SUFFIX = "FinderMethodInterceptor"

    def self.included(base)
      # Implementando "ActiveSupport::Concern" em Ruby puro, uma vez que a ideia
      # é extrair
      base.extend ClassMethods
      interceptor = const_set "#{base.name}#{INTERCEPTOR_SUFFIX}", Module.new
      base.prepend interceptor
    end

    # :reek:IrresponsibleModule
    module ClassMethods

      #
      # Declara um método finder - método que retorna um escopo.
      # Deve-se definir quais atributos o finder requer para sua execução.
      #
      # Ex:
      #   - finder simples, sem requerimentos
      #   ```
      #   class BookSearch < Finders::Search
      #     # quaisquer atributos
      #
      #     # finders
      #     finder :published
      #
      #     def published
      #       # Esse escopo não depende de nenhum atributo de busca
      #       where(published: true)
      #     end
      #   end
      #   ```
      #
      #   # finder com requerimentos
      #   - finder :fans, requires: :band
      #   ```
      #   class UserSearch < Finders::Search
      #     attribute :band, :string
      #
      #     finder :fans, requires: :band
      #
      #     def fans
      #       # esse finder method usa o atributo `:band` para construir seu escopo!
      #       joins(likes: :bands).where(bands: { name: band })
      #     end
      #   end
      #   ```
      #
      # :reek:TooManyStatements
      # :reek:NilCheck
      def finder(method, requires: nil, **options)
        @finders ||= {}
        @finders[method] = { requires: requires, **options }

        interceptor = const_get "#{name}#{INTERCEPTOR_SUFFIX}"
        required_attrs = requires.nil? ? [] : Array(requires)

        interceptor.class_eval do
          define_method(method) do |*args, &block|
            # Não aplica o escopo à busca caso os atributos requeridos não
            # sejam válidos.
            return self unless required_attrs.all? { |attr_name| valid_attr?(attr_name) }

            # Mergeando o escopo à busca, caso o retorno não seja "falsy".
            # Uma vez que os métodos são delegados ao `@scope` (Decorator),
            # qualquer `where` será acrescido a `@scope.where`. Assim, estamos
            # fazendo `@scope = @scope.where(**conditions)`.
            finder_scope = if defined?(super)
                             # se for método definido na classe de busca, use-o
                             super(*args, &block)
                           else
                             # senão, delegue o método para o scope (reaproveitando métodos no Model)
                             default_attrs = required_attrs.map { |attr_name| send(attr_name) }
                             attrs = default_attrs.each_with_index do |_value, idx|
                               args.size > idx + 1 ? args[idx] : default_attrs[idx]
                             end

                             scope.send(method, *attrs, &block)
                           end

            @scope = finder_scope if finder_scope
            # Antes, fazíamos uso do `#merge`, mas isso requeria que os métodos
            # de query (QueryMethods do ActiveRecord) fossem delegados à
            # `default_scope` e não a `scope`, para evitar repetição de
            # condições.
            # `@scope = @scope.merge finder_scope if finder_scope`

            # retornando a busca, para permitir chainning
            self
          end
        end
      end


      #
      # [getter/setter]
      # Declara múltiplos métodos finders de uma vez, retornando todas as
      # definições de finders existentes.
      #
      def finders(*simple_finders, **finders)
        @finders ||= {}
        return @finders if simple_finders.blank? && finders.blank?

        simple_finders.each { |name| finder(name) }
        finders.each_pair { |name, options| finder(name, options) }

        @finders
      end
    end
  end
end
