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
end
