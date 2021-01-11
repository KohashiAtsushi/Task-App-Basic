# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

3.times do |user_id|
  50.times do |n|
  index  = "タスク内容#{n+1}"
  contents = "タスク内容#{n+1}"
  Task.create!(index: index,
               contents: contents,
               user_id: (user_id + 1))
  end
end