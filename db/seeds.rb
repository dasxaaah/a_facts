# create_users(10)

# def create_users(quantity)
#   i = 0

#   quantity.times do
#     user_data = {
#       email: "user_#{i}@email.com",
#       password: 'testtest'
#     }

#     user = User.create!(user_data)
#     puts "User created with id #{user.id}"

#     i += 1
#   end
# end

author = User.first || User.create!(email: "user0@example.com", password: "testtest")
Post.find_or_create_by!(title: "Какой софт для трекинга при параллаксе?") do |p|
  p.body      = "Нужен совет по пайплайну (Nuke/AE, FBX и т.д.)."
end
