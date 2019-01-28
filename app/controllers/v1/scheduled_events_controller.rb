class V1::ScheduledEventsController < ApplicationController
  before_action :set_scheduled_event, only: [:show, :update, :destroy]

  # GET /scheduled_events
  def index
    @scheduled_events = ScheduledEvent.all

    render json: @scheduled_events
  end

  # GET /scheduled_events/1
  def show
    render json: @scheduled_event
  end

  # POST /scheduled_events
  def create
    @scheduled_event = ScheduledEvent.new(scheduled_event_params)

    if @scheduled_event.save
      render json: @scheduled_event, status: :created
    else
      render json: @scheduled_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scheduled_events/1
  def update
    if @scheduled_event.update(scheduled_event_params)
      render json: @scheduled_event
    else
      render json: @scheduled_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scheduled_events/1
  def destroy
    @scheduled_event.destroy
  end

  private

  def set_scheduled_event
    @scheduled_event = ScheduledEvent.find(params[:id])
  end

  def scheduled_event_params
    params.require(:scheduled_event).permit(
      :pitch_id, :user_id, :first_date,
      :last_date, :starting_hour, :finishing_hour,
      :interval, :interval_type, :canceled
    )
  end
end
