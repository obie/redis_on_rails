class AdditionalFields < ActiveRecord::Migration
  def change
    add_column :attendees, :email, :string
  end
end
