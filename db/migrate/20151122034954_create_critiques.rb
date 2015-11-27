class CreateCritiques < ActiveRecord::Migration
  def change
    create_table :critiques do |t|
      t.text :first_impressions
      t.text :lighting
      t.text :composition
      t.references :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
