class CreateLegoSets < ActiveRecord::Migration[5.1]
  def change
    create_table :lego_sets do |t|
      t.string :set_id
      t.string :name
      t.string :thumbnail_url
      t.string :instructions_url

      t.timestamps
    end
  end
end
