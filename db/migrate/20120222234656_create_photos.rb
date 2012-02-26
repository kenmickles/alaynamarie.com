class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.integer :book_id
      t.integer :weight, :default => 0
      
      # paperclip fields
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
    
    add_index :photos, :book_id
    add_index :photos, :weight
  end
end
