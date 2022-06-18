class NodesController < ApplicationController
  before_action :set_node, only: %i[ show update destroy ]

  # GET /nodes
  def index
    @nodes = Node.all
    render json: NodeSerializer.new(@nodes).serializable_hash
  end

  # GET /nodes/1
  def show
    render json: NodeSerializer.new(@node).serializable_hash
  end

  # POST /nodes
  def create    
    @node = NodeCreator.new(node_params).create_node  

    if @node.errors.any?
      render json: @node.errors, status: :unprocessable_entity                 
    else
      render json: NodeSerializer.new(@node).serializable_hash, status: :created, location: @node   
    end
  end

  # PATCH/PUT /nodes/1
  def update
    @node = NodeUpdater.new(@node, node_params).update_node  
    if @node.errors.any?
      render json: @node.errors, status: :unprocessable_entity                 
    else
      render json: NodeSerializer.new(@node).serializable_hash
    end        
  end

  # DELETE /nodes/1
  def destroy
    @node.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def node_params
      params.permit(:name, :parent_id)
    end
end
