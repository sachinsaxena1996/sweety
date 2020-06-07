# frozen_string_literal: true

# class for migration
class CreateGlucoseLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :glucose_levels do |t|
      t.date :observation_date
      t.integer :user_id
      t.json :observations

      t.timestamps
    end
  end
end
