class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :slug
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :event_link
      t.string :source

      t.timestamps
    end
  end
end
