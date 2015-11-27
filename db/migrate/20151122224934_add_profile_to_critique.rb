class AddProfileToCritique < ActiveRecord::Migration
  def change
    add_reference :critiques, :profile, index: true, foreign_key: true
  end
end
