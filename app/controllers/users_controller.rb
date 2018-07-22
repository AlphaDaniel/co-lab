class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def index
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
      @users = @project.try(:users)
      
      if @project.nil?
        redirect_to root_path, alert: "Invalid Url" 
      end
      
      @heading = 'Collaborators'
    else
      @heading = 'Active Members'
      @users = User.all
    end
  end
  
private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
