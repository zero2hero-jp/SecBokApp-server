class Api::V1::SheetsController < Api::V1::ApiController
  before_action :set_sheet, only: %i[ show update ]

  def index
    @sheets = Sheet.all

    render json: @sheets
  end

  def show
    render json: @sheet
  end

  # POST /sheets
  # From google form send button.
  def create
    @sheet = Sheet.find_by(email: params[:sheet][:email])

    # メールに対応するシートがある
    if @sheet
      render_remined

    # メールに対応するシートが無い
    else
      @sheet = Sheet.new(sheet_params)
      @sheet.build

      if @sheet.save!
        SheetMailer.send_sheet_and_report_url(@sheet).deliver_now
        render json: @sheet, status: :created
      else
        render json: @sheet.errors, status: :unprocessable_entity
      end
    end
  end

  # PUT /sheets/[:spreadsheet_id]
  # From google spreadsheet send button.
  def update
    # TODO:
    # インプットがシートなので、IDがパラメータで渡ってこないため
    # アップデートしようとすると全てインサートになる。
    # アップデートする前に、関連レコードを全消しする。
    if @sheet.update(sheet_params)
      render_remined
    else
      render json: @sheet.errors, status: :unprocessable_entity
    end
  end

  private
    def set_sheet
      @sheet = Sheet.find_by(spreadsheet_id: params[:id])
    end

    def sheet_params
      params.fetch(:sheet, {}).permit(
        :email,
        :spreadsheet_id,
        years_attributes: [:title, :l, :m, :h],
        knowledges_attributes: [:role, :score]
      )
    end

    def render_remined
      SheetMailer.send_sheet_and_report_url(@sheet).deliver_now
      render json: @sheet, status: :ok
    end
end
