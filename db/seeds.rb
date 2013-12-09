# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# fetch photos from old location
# Photo.all.each do |photo|
#   file_name = "/Users/ken/Desktop/photos/#{photo.id}.jpg"
#   if File.exists?(file_name)
#     photo.image = File.new(file_name)
#     photo.save!
#   end
# end

Setting.create([
  {name: 'tagline', value: 'Makeup and Hair', description: 'The text next to the logo.'},
  {name: 'title', value: 'Alayna Marie Rakes: Professional Makeup Artist, Philadelphia, New Jersey, New York', description: 'Document title for book pages.'},
  {name: 'short_title', value: 'Alayna Marie Rakes', description: 'Document title for other pages (with titles).'},
  {name: 'wedding_title', value: 'Alayna Marie Rakes: Weddings', description: 'Document title for weddings section.'},
  {name: 'description', value: 'Alayna Rakes is a professional makeup artist serving the fashion and entertainment industries.', description: 'Meta tag description for search engines.'}
])