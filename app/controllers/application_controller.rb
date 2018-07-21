class ApplicationController < ActionController::Base
  helper_method [:all_projects, :log_in_required]
  
  def log_in_required
    redirect_to new_user_session_path, alert: "Must be logged in" unless user_signed_in?
  end
  
  def all_projects
    @projects = Project.all
  end
end
