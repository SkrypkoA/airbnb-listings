class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.string :entire_url
      t.string :uid
      t.string :name
      t.string :medium_url
      t.string :market
      t.string :price_formatted
      t.string :city
      t.string :country
      t.string :state
      t.timestamps
    end
  end
end
