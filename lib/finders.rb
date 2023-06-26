#
# Finders
#
# Provê objetos para representação de buscas - decorators sobre um escopo
# padrão - isolando as funcionalidades de busca (métodos finders, que retornam
# escopos) e facilitando a "conversão" de tipos de atributos.
#
module Finders; end

# auto requiring
Dir[File.join(__dir__, "finders", "*.rb")].sort.each { |file| require_dependency file }
