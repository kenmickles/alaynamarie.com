# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# fetch photos from old location
Photo.all.each do |photo|
  file_name = "/Users/ken/Desktop/photos/#{photo.id}.jpg"
  if File.exists?(file_name)
    photo.image = File.new(file_name)
    photo.save!
  end
end
