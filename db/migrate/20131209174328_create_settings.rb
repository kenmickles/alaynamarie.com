class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, :limit => 64, :null => false
      t.string :value
      t.text :description
    end
    add_index :settings, :name, :unique => true
  end
end
