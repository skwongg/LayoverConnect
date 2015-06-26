class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :description
      t.string :location_summary
      t.datetime :start_time
      t.datetime :end_time
      t.string :image
      t.boolean :security
      t.integer :terminal_id
      t.timestamps null: false
    end
  end
end
