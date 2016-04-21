# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# The code below adds 100 entries to the awesomeAnswers db on db:seed
# 100.times do
# Question.create   title:    Faker::Company.bs,
#                   body:     Faker::Lorem.paragraph,
#                   view_count: 0
# end
#
# puts Cowsay.say("Generated 100 questions!")

#This creates 100 users
# 100.times do
# User.create   first_name:    Faker::Name.first_name,
#               last_name:     Faker::Name.last_name,
#               email:         Faker::Internet.email
# end
#
# puts Cowsay.say("Generated 100 users master!")

# This creates 100 products with price and sale price
# 100.times do
# price = Faker::Commerce.price
# Product.create  name:       Faker::Commerce.product_name,
#                 price:      price,
#                 sale_price: price * 0.8,
#                 hit_count: 0
# end
#
# puts Cowsay.say("Generated 100 products for you master!")

100.times do
  q = Question.create title:      Faker::Company.bs,
                      body:       Faker::Lorem.paragraph,
                      view_count: 0
  10.times do
    random = rand(20)
    if random < 10
      q.answers.create(body: Faker::StarWars.quote)
    else
      q.answers.create(body: Faker::ChuckNorris.fact)
    end
  end
end

10.times do
  Category.create(name: Faker::Hacker.adjective)
end

puts Cowsay.say("Generated a 100 questions and 10 categories!")
