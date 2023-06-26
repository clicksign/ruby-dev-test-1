class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Sort records by date of creation instead of primary key
  self.implicit_order_column = :created_at
end
