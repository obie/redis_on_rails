class AddAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications, force: true do |t|
      t.string   :type
      t.integer  :attendee_id
      t.string   :provider
      t.string   :uid
      t.timestamps
    end
  end
end
