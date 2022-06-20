# frozen_string_literal: true

FactoryBot.define do
  factory :widget, class: 'Widget' do
    name { Faker::Company.name }
  end
end
