class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method [:all_projects, :log_in_required]
  
private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def log_in_required
    redirect_to new_user_session_path, alert: "Must be logged in" unless user_signed_in?
  end
  
  def all_projects
    @projects = Project.all_desc
  end
end
