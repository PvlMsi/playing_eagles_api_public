class V1::GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  # GET /games
  def index
    @q = Game.upcoming.includes(:pitch).includes(:players).ransack params[:q]
    @games = @q.result.page(page).per(per_page)

    set_pagination_headers

    render :index
  end

  def game_history
    @user = User.find(params[:id])
    @games = Game.select { |g| g.players.find_by_user_id(@user.id).present? }

    render :game_history
  end

  # GET /games/1
  def show
    render :show
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      render :show, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render :show, status: :ok
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    if @game.destroy
      render json: { message: 'deleted' }, status: :ok
    else
      render json: { errors: @game.errors.full_messages }
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:pitch_id, :date, :players_quantity, :time_length, :user_id)
  end

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end

  def set_pagination_headers
    headers['X-Total-Count'] = @games.total_count
    links = []
    links << page_link(@games.prev_page, 'prev') if @games.prev_page
    links << page_link(@games.next_page, 'next') if @games.next_page
    headers['Link'] = links.join(', ') if links.present?
  end

  def page_link(page, rel)
    "<#{v1_games_path(request.query_parameters.merge(page: page))}>; rel=#{rel}"
  end
end
