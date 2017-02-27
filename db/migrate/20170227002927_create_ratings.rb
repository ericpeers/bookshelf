class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :user
      t.boolean :was_read
      t.float :rating
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
