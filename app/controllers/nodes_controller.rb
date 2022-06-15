class NodesController < ApplicationController

  before_action :set_node

  def show
    respond_to do |format|
      format.html { render :show }
    end
  end

  def new
    @node_new = Node.new(node_type: params[:node_type], node_id: @node.id)

    respond_to do |format|
      format.js { render :new, layout: false }
    end
  end

  def create
    @node_new = Node.new(node_params)

    @node_new.save

    respond_to do |format|
      format.js { render :create, layout: false }
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.js { render :destroy, layout: false }
    end
  end

  private

  def set_node
    if params[:node_id].blank?
      @node = Node.where(node_id: nil).last
    else
      @node = Node.find_by_id(params[:node_id])
    end
  end

  def node_params
    params.require(:node).permit(:name, :content, :node_type, :node_id)
  end

end