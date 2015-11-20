class CreateOpenPeriods < ActiveRecord::Migration
  def change
    create_table :open_periods do |t|
      t.references :pharmacy, index: true, foreign_key: true
      t.string :day, null: false
      t.time :time_from, default: "09:00", null: false
      t.time :time_to, default: "17:00", null: false
      t.timestamps null: false
    end
  end
end
