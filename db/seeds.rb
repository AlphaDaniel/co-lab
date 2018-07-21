#=========================================================================== 
# users
#   t.string "name"
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "image"
#   t.string "uid"

# projects
#   t.string "name"
#   t.string "lang"
#   t.string "description"

# user_projects
#     t.integer "user_id"
#     t.integer "project_id"
#     t.string "role"
#=========================================================================== 
# reset
User.destroy_all
Project.destroy_all
UserProject.destroy_all

# create users
until User.count == 30 do
  User.create(name: Faker::Name.first_name, email: Faker::Internet.free_email, password: Faker::Internet.password(6,6))
end

# create projects
until Project.count == 10 do
  Project.create(name: Faker::App.name, lang: Faker::ProgrammingLanguage.name, description: Faker::Lorem.paragraph_by_chars(200))
end

# set project creators
ids = (1..10).to_a; i = 0

until  i == 10 do
  UserProject.create(user_id: i+1, project_id: ids[i], role: 'Creator')
  i += 1
end

# set collaborators
i = 11

until UserProject.count == 30 do
  UserProject.create(user_id: i, project_id: rand(1..10), role: 'Collaborator')
  i += 1
end

# for testing
user = User.create(name: "admin", email: "admin@colab.com", password: "123456")
project = Project.create(name: "For Testing", lang: "Ruby", description: "Dummy project for testing")
up = UserProject.create(user_id: user.id, project_id: project.id, role: "Creator")
# Project.find(11)
# Project.find(11).user_projects

# report
uc = User.count
pc = Project.count
upc = UserProject.count

puts ["\n Created #{uc}", 'user'.pluralize(uc), "#{pc}", 'project'.pluralize(pc), "and #{upc}", 'association'.pluralize(upc)].join(" ").light_green