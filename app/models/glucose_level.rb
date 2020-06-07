# frozen_string_literal: true

class GlucoseLevel < ApplicationRecord
  store :observations, coder: JSON
  validate :observations_per_day_count
  scope :current_user_glucose_levels, ->(user_id) { where(user_id: user_id) }

  belongs_to :user

  def observations_per_day_count
    if observations.count > 4
      errors.add(:observations, 'you can have only 4 observations per day')
    end
  end

  def add_observation(observation)
    key = observations.count + 1
    observations[key.to_s] = observation
    self
  end

  def self.create_new_observation(glucose_level_params, user_id)
    glucose_level = GlucoseLevel.new
    glucose_level.observations['1'] = glucose_level_params[:observations]
    glucose_level.observation_date = glucose_level_params['observation_date']
    glucose_level.user_id = user_id
    glucose_level
  end

  def self.daily_report(valid_params, user_id)
    GlucoseLevel.current_user_glucose_levels(user_id).where('observation_date >= ? AND observation_date <= ?', valid_params['start_date'], valid_params['end_date'])
  end

  def self.month_to_date_report(end_date, user_id)
    arr = end_date.split('-')
    arr[2] = '01'
    GlucoseLevel.current_user_glucose_levels(user_id).where('observation_date >= ? AND observation_date <= ?', arr.join('-'), end_date)
  end

  def self.monthly_report(end_date, user_id)
    arr = end_date.split('-')
    arr[1] = (arr[1].to_i - 1)
    arr[2] = '01'
    month_start_date = arr.join('-')
    arr[2] = '31' if arr[1].to_i.odd?
    arr[2] = '30' if arr[1].to_i.even?
    month_end_date = arr.join('-')
    GlucoseLevel.current_user_glucose_levels(user_id).where('observation_date >= ? AND observation_date <= ?', month_start_date, month_end_date)
  end
end
