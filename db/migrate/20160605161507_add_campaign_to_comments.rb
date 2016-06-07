class AddCampaignToComments < ActiveRecord::Migration
  def change
    add_column :comments, :campaign_id, :integer
    add_index :comments, :campaign_id
    add_reference :comments, :user, index: true, foreign_key: true
  end
end
