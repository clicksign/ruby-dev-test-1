class NodeUpdater
    def initialize(node, node_params)
			@node = node
      @name = node_params[:name]
      @parent_id = node_params[:parent_id]
    end
  
    def update_node
      @node.update(
        name: @name,
        parent_id: @parent_id
      )
			@node
    end
end
  