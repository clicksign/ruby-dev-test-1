class Node < ApplicationRecord
  enum node_type: %i[directory file]

  has_one_attached :content

  belongs_to :node, optional: true
  has_many :nodes

  validates :name, :node_type, presence: true
  validates :content, presence: true, if: -> { file? }

  def path
    return name if node.nil?

    "#{Node.find(node_id).path}/#{name}"
  end
end
