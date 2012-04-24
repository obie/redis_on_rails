class AddTables < ActiveRecord::Migration
  def change
    create_table :attendees, :force => true do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :conferences, :force => true do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :events, :force => true do |t|
      t.string :type, null: false, default: "Event"
      t.timestamps
    end

    create_table :speakers, :force => true do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :talks, :force => true do |t|
      t.string :name, null: false
      t.integer :speaker_id, null: false
      t.timestamps
    end
  end
end
