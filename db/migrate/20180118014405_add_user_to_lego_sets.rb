class AddUserToLegoSets < ActiveRecord::Migration[5.1]
  def change
    add_reference :lego_sets, :user, foreign_key: true
  end
end
