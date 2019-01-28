class V1::OpinionsController < ApplicationController
  before_action :set_opinion, only: [:show, :update, :destroy]

  # GET /opinions
  def index
    @opinions = User.find(params[:id]).opinions.page(page).per(per_page)
    set_pagination_headers(params[:id])

    render :index
  end

  # GET /opinions/1
  def show
    render json: @opinion
  end

  # POST /opinions
  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.issuing_user = current_user

    if @opinion.save
      render json: @opinion, status: :created
    else
      render json: @opinion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /opinions/1
  def update
    if @opinion.update(opinion_params)
      render json: @opinion
    else
      render json: @opinion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /opinions/1
  def destroy
    @opinion.destroy
  end

  private

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  def opinion_params
    params.require(:opinion).permit(
      :player_id,
      :game_id,
      :description,
      :anonymous,
      :fair_play_rate,
      :would_recommend_rate,
    )
  end

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end

  def set_pagination_headers(user_id)
    headers['X-Total-Count'] = @opinions.total_count
    links = []
    links << page_link(@opinions.prev_page, 'prev', user_id) if @opinions.prev_page
    links << page_link(@opinions.next_page, 'next', user_id) if @opinions.next_page
    headers['Link'] = links.join(', ') if links.present?
  end

  def page_link(page, rel, user_id)
    "<#{opinions_v1_user_path(request.query_parameters.merge(page: page))}>; rel=#{rel}"
  end
end
