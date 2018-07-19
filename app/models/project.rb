class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects
  
  validates :name, :lang, :description, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 10 }
end
