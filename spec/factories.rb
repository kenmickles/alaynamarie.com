require 'faker'

FactoryGirl.define do
  factory :book do |f|
    f.name { Faker::Company::catch_phrase }
    f.description { Faker::Company::bs }
  end

  factory :photo do |f|
    f.caption { Faker::Company::bs }
    f.book { create(:book) }
    f.image { File.open(Dir.glob(File.join(Rails.root, 'spec', 'images', '*')).sample) }
  end

  factory :page do |f|
    f.title { Faker::Company::bs }
    f.url { Faker::Lorem.word.parameterize }
    f.body { Faker::Lorem.paragraphs(3) }
  end

  factory :setting do |f|
    f.name { Faker::Lorem.word.downcase }
    f.value { Faker::Lorem.sentence }
    f.description { Faker::Lorem.paragraphs(1) }
  end
end