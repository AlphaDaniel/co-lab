class UsersController < ApplicationController
  def index
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
      @users = @project.users
      @type = 'Collaborators'
      
      return redirect_to project_path(@project) if @project.nil?
    end
  end
end
