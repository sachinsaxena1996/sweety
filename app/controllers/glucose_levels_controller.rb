# frozen_string_literal: true

# GlucoseLevelsController
class GlucoseLevelsController < ApplicationController
  before_action :set_glucose_level, only: %i[show edit update destroy]

  # GET /glucose_levels
  # GET /glucose_levels.json
  def index
    @glucose_levels = GlucoseLevel.current_user_glucose_levels(current_user.id)
  end

  # GET /glucose_levels/1
  # GET /glucose_levels/1.json
  def show; end

  def new_daily_report; end

  def daily_report
    @glucose_levels = GlucoseLevel.daily_report(valid_params, current_user.id)
  end

  def new_month_to_date_report; end

  def month_to_date_report
    @glucose_levels = GlucoseLevel.month_to_date_report(
      valid_params['end_date'], current_user.id
    )
  end

  def new_monthly_report; end

  def monthly_report
    @glucose_levels = GlucoseLevel.monthly_report(valid_params['end_date'],
                                                  current_user.id)
  end

  # GET /glucose_levels/new
  def new
    @glucose_level = GlucoseLevel.new
  end

  # GET /glucose_levels/1/edit
  def edit; end

  # POST /glucose_levels
  # POST /glucose_levels.json

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def create
    @glucose_level = GlucoseLevel
                     .where(observation_date:
                      glucose_level_params['observation_date'],
                            user_id: current_user.id).first
    if @glucose_level.present?
      @glucose_level = @glucose_level
                       .add_observation(glucose_level_params[:observations])
    else
      @glucose_level = GlucoseLevel.create_new_observation(glucose_level_params,
                                                           current_user.id)
    end

    respond_to do |format|
      if @glucose_level.save
        format.html do
          redirect_to @glucose_level,
                      notice: 'Glucose level was successfully created.'
        end
        format.json { render :show, status: :created, location: @glucose_level }
      else
        format.html { render :new }
        format.json do
          render json: @glucose_level.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # PATCH/PUT /glucose_levels/1
  # PATCH/PUT /glucose_levels/1.json
  def update
    respond_to do |format|
      if @glucose_level.update(glucose_level_params)
        format.html do
          redirect_to @glucose_level,
                      notice: 'Glucose level was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @glucose_level }
      else
        format.html { render :edit }
        format.json do
          render json: @glucose_level.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # DELETE /glucose_levels/1
  # DELETE /glucose_levels/1.json
  def destroy
    @glucose_level.destroy
    respond_to do |format|
      format.html do
        redirect_to glucose_levels_url,
                    notice: 'Glucose level was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_glucose_level
    @glucose_level = GlucoseLevel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def glucose_level_params
    params.require(:glucose_level)
          .permit(:observation_date, :user_id, :observations)
  end

  def valid_params
    params.permit(:start_date, :end_date)
  end
end
