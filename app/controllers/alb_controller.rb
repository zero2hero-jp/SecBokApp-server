class AlbController < ApplicationController
  def health_check
    render status: :ok, json: { message: 'ok' }
  end
end
