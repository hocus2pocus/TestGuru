# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users_array = Array.new(3) do |user|
#   User.create!(
#     login: "User_#{user + 1}",
#     password: "password",
#     email: "email"
#   )
# end

# puts "3 users created"

categories_array = Array.new(3) do |category|
  Category.create!(
    title: "Category_#{category + 1}"
  )
end

puts "3 categories created"

5.times do |test|
  Test.create!(
    title: "Test_#{test + 1}",
    level: rand(1..5),
    author_id: User.first.id,
    category_id: categories_array.sample.id
  )
end

puts "5 tests created"

Test.find_each(batch_size: 5) do |test|
  Question.create!(body: "#{test.title}, Question_1",
                   test_id: test.id)

  Question.create!(body: "#{test.title}, Question_2",
                   test_id: test.id)
end

puts "10 questions created"

Question.find_each(batch_size: 10) do |qustion|
  Answer.create!(body: "Answer for #{qustion.body}",
                 question_id: qustion.id,
                 correct: true)

  Answer.create!(body: "Answer for #{qustion.body}",
                 question_id: qustion.id)

  Answer.create!(body: "Answer for #{qustion.body}",
                 question_id: qustion.id)

  Answer.create!(body: "Answer for #{qustion.body}",
                 question_id: qustion.id)
end

puts "50 answers created"

