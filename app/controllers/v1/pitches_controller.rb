class V1::PitchesController < ApplicationController
  before_action :set_pitch, only: [:show, :update, :destroy]

  # GET /pitches
  def index
    @q = Pitch.ransack params[:q]
    @pitches = @q.result.page(page).per(per_page)

    set_pagination_headers

    render :index
  end

  # GET /pitches/1
  def show
    render :show
  end

  # POST /pitches
  def create
    @pitch = Pitch.new(pitch_params)

    if @pitch.save
      render json: @pitch, status: :created
    else
      render json: @pitch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pitches/1
  def update
    if @pitch.update(pitch_params)
      render json: @pitch
    else
      render json: @pitch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pitches/1
  def destroy
    @pitch.destroy
  end

  def calendar
    date = params[:date].to_date
    @pitch = Pitch.includes(:scheduled_events, :games).find(params[:id])
    @events = @pitch.scheduled_events.get_by_date(date) + @pitch.games.todays(date)
    render :calendar
  end

  private

  def set_pitch
    @pitch = Pitch.find(params[:id])
  end

  def pitch_params
    params.require(:pitch).permit(:city, :address, :opening_hour, :closing_hour)
  end

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end

  def set_pagination_headers
    headers['X-Total-Count'] = @pitches.total_count
    links = []
    links << page_link(@pitches.prev_page, 'prev') if @pitches.prev_page
    links << page_link(@pitches.next_page, 'next') if @pitches.next_page
    headers['Link'] = links.join(', ') if links.present?
  end

  def page_link(page, rel)
    "<#{v1_pitches_path(request.query_parameters.merge(page: page))}>; rel=#{rel}"
  end
end
