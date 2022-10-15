class Api::V1::FormsController < Api::V1::ApiController
  def index
    @forms = Form.all

    render json: @forms
  end

  def show
    render json: @form
  end

  def update
    logger.info("#####################")
    logger.info(form_params)
    logger.info("#####################")
=begin
    if @form.update(form_params)
      render json: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
=end

    render json: { message: 'ok' }, status: :ok
  end

  private
    def form_params
      params.require(:form).permit(
        :email,
        rows: [
          :secBokId, 
          :knowledge, 
          :years
        ]
      )
    end
end
