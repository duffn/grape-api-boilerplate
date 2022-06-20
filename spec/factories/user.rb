# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'password1' }
  end
end
