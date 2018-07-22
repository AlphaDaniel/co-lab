class ProjectsController < ApplicationController
  helper_method [:project_errors]
  before_action :log_in_required
  before_action :set_project, only: [:show, :edit, :update]
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    
    if @project.save
      up = UserProject.new(user_id: current_user.id, project_id: @project.id, role: 'Creator')
      up.save
      redirect_to @project
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    @project.update(project_params) ? (redirect_to @project, notice: 'Updated') : (render :edit)
  end
  
private

  def set_project
    @project = Project.find_by(id: params[:id])
  end
  
  def project_params
    params.require(:project).permit(
      :name,
      :lang,
      :description,
    )
  end
  
  def project_errors
    @project.errors.full_messages
  end
end
