class NodeCreator
    def initialize(node_params)
      @name = node_params[:name]
      @parent_id = node_params[:parent_id]
    end
  
    def create_node
      Node.create(
        name: @name,
        parent_id: @parent_id
      )      
    end
  end
  