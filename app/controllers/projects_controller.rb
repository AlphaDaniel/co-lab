class ProjectsController < ApplicationController
  before_action :log_in_required
  before_action :set_project, only: [:show]
  
  def show
  end
  
private

  def set_project
    @project = Project.find_by(id: params[:id])
  end
end
