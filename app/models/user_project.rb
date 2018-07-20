class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validate :user_uniq_to_project, :one_creator
 
  def user_uniq_to_project
    if UserProject.where(user_id: user_id, project_id: project_id).present?
      errors.add(:user_id, "You are already a collaborator on this project")
    end
  end
  
  def one_creator
    if UserProject.where(project_id: project_id, role: "Creator").present? && role == "Creator"
      errors.add(:role, "Project allowed only 1 creator")
    end
  end
end
