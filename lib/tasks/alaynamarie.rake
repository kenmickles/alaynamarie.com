namespace :alaynamarie do
  
  desc "Import photos from the old site (and delete all existing photos from the current one)"
  task :migrate_photos => :environment do
    require 'open-uri'
          
    # remove existing photos
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE photos")
    
    # copy photos from the old db to the new one
    rows = ActiveRecord::Base.connection.select_all "SELECT * FROM `alaynamarie.com_development`.photos WHERE book_id IS NOT NULL"
    rows.each_with_index do |row, i|
      photo = Photo.new(row)
      photo.id = row['id']
      
      image_url = "http://assets.alaynamarie.com.s3.amazonaws.com/photos/#{photo.id}.jpg"
      tmp_path = "/tmp/#{photo.id}.jpg"
      
      open(tmp_path, 'wb') do |file|
        file << open(image_url).read
      end
      
      photo.image = File.open(tmp_path)

      if !photo.save
        puts photo.errors.inspect
      end
      
      puts "Migrated photo ##{photo.id}: #{photo.image.url} (#{i+1} of #{rows.count})"
    end
  end
  
end