class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects
  
  validates :name, :description, presence: true
  validates :lang, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 10 }
  
  HUMANIZED_ATTRIBUTES = {
  :lang => "Language"
  }
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  def self.all_desc
    order(created_at: :desc)
  end
  
  def creator
    user_projects.where(role: 'Creator')[0].user
  end
  
  def collaborators
    user_projects.where(role: "Collaborator").map {|up| up.user}
  end
  
  def is_collaborator?(user)
    collaborators.include?(user)
  end
end
