require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :contact do
    firstname Faker::Name.first_name
    lastname  Faker::Name.last_name
    email     { Faker::Internet.email("#{firstname}.#{lastname}") }
  end
end


