class NodePath
  def initialize(node)
    @node = node
  end

  def path
    get_path(@node)
  end

  private 
  def get_path(node)
    if node.parent_id.nil?
      return node.name
    else
      return get_path(Node.find(node.parent_id)) + "/" + node.name
    end
  end
end
  