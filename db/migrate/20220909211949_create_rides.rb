class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.references :amusement_park, foreign_key: true
      t.string :name
      t.integer :thrill_rating
      t.boolean :open

      t.timestamps
    end
  end
end
