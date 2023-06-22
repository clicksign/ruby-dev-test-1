# frozen_string_literal: true

class V1::FoldersController < V1::BaseController
  private

  def record_params
    params.require(:folder).permit(:name, :parent_folder_id, :user_id)
  end

  def include_relations
    %i[archives]
  end
end
