# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe GlucoseLevel, type: :model do
  let!(:glucose_level) do
    create(:glucose_level,
           user_id: current_user.id,
           observation_date: Time.now.to_date.strftime('%Y-%m-%d'))
  end
  let!(:glucose_level_1) do
    create(:glucose_level,
           user_id: current_user.id,
           observation_date: (Time.now + 2.days).to_date.strftime('%Y-%m-%d'))
  end
  let(:current_user) { create(:user) }
  describe 'observations_per_day_count' do
    it 'does not allows more than 4 observations per day' do
      4.times do
        glucose_level.add_observation(10)
      end
      expect(glucose_level).to be_valid
      glucose_level.add_observation(10)
      expect(glucose_level).to be_invalid
      error_message = 'you can have only 4 observations per day'
      expect(glucose_level.errors['observations'].first).to eq(error_message)
    end
  end

  describe '#add_observation' do
    it 'adds a new observation in observations json' do
      expect(glucose_level.observations.count).to eq(0)
      glucose_level.add_observation(10)
      expect(glucose_level.observations.count).to eq(1)
    end
  end

  describe '#daily_report' do
    it 'generates the report from start date to end date' do
      records = GlucoseLevel.daily_report(
        { 'start_date' => Time.now.to_date.strftime('%Y-%m-%d'),
          'end_date' => (Time.now + 2.days).to_date.strftime('%Y-%m-%d') },
        current_user.id
      )
      expect(records.count).to eq(2)
    end
  end
end
# rubocop: enable Metrics/BlockLength
