class AlbController < ApplicationController
  def health_check
    render json: { message: 'ok' }, status: :ok
  end
end
