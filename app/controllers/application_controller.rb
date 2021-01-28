# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  private

  def show_errors(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
end
