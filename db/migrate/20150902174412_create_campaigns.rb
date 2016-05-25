class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :objective
      t.text :description
      t.string :ownership
      t.string :category
      t.string :comments
      t.string :preferred_currency
      t.string :location
      t.string :website
      t.float :rating
      t.text :tags
      t.integer :votes
      t.integer :views, default: 0
      t.string :qr_code
      t.string :cover_image
      t.string :goal

      t.timestamps null: false
    end
  end
end
