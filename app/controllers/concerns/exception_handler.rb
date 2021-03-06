# Define custom exception handlers
module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  # JSON response with message; Status code 401 - Unauthorized
  def four_zero_one(err)
    render json: { message: err.message }, status: :unauthorized
  end

  # JSON response with message; Status code 422 - Unprocessable Entity
  def four_twenty_two(err)
    render json: { message: err.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 498 - Invalid Token
  def four_ninety_eight(err)
    render json: { message: err.message }, status: :unauthorized
  end
end