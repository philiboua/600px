class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :photo_upload
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
