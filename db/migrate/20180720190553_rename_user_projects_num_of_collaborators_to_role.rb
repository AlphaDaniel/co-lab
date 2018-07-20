class RenameUserProjectsNumOfCollaboratorsToRole < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_projects, :num_of_collaborators, :role
  end
end
