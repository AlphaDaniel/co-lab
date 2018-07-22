class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def index
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
      @users = @project.users
      @type = 'Collaborators'
      
      return redirect_to project_path(@project) if @project.nil?
    end
  end
  
private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
