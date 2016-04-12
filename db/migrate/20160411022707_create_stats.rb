class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :host
      t.string :pathname
      t.integer :averagetime
      t.integer :visits

      t.timestamps null: false
    end
  end
end
