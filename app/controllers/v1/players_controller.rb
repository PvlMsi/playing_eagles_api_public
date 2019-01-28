class V1::PlayersController < ApplicationController
  before_action :set_player, only: %i[show sign_in sign_out]

  # GET /players/1
  def show
    render json: @player
  end

  def sign_in
    already_signed = @player.game.players.select{ |p| p.user_id == current_user.id }.first
    @player.user = current_user
    if (@player.save && !!already_signed && already_signed.update_attributes(user_id: nil)) || (@player.save && !already_signed)
      render :sign_in
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def sign_out
    already_signed = @player.game.players.select{ |p| p.user_id == current_user.id }.first
    if already_signed.present? && @player.update_attributes(user: nil)
      render :sign_out
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(
      :user_id,
      :game_id,
      :position
    )
  end
end
