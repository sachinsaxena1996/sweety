# frozen_string_literal: true

json.array! @glucose_levels,
            partial: 'glucose_levels/glucose_level',
            as: :glucose_level
