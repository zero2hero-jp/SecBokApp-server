class Api::V1::SheetsController < Api::V1::ApiController
  before_action :set_sheet, only: %i[ show update ]

  # TODO: テスト実装
  def index
    @sheets = Sheet.all

    render json: @sheets, 
      root: 'data', 
      adapter: :json, 
      each_serializer: SheetSerializer, 
      status: :ok
  end

  # TODO: テスト実装
  def show
    # TODO: [TBD]serializerで返す値を実装。IDしか返っていない。それでもいいかも？
    render serializer_json, status: :ok
  end

  # POST /sheets (From google form send button.)
  #
  # if メールアドレスの登録がない場合は、
  #   (初回登録作業)
  #   1. シートをコピー
  #   2. シート対する権限をメアドに与える
  #   3. シートモデルを作成して保存する
  #   4. シートとレポートのURLをメールに送信する
  #
  # else メールアドレスが登録済みの場合は、
  #   (リマインド)
  #   1. シートとレポートのURLをメールに送信する
  #
  # TODO: テスト実装
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
        render serializer_json, status: :created
      else
        render json: @sheet.errors, status: :unprocessable_entity
      end
    end

  # 処理されないStandardErrorをキャッチ
  rescue => e
    # TODO: rescueを実装せずに外部注入する
    goodbye(e)
  end

  # PUT /sheets/[:spreadsheet_id] (From google spreadsheet send button.)
  #
  # spreadsheetから送信されてきたパラメータを使用して、以下の作業をする。
  # 1. Sheetに関連するモデルを全削＆全保存。
  # 2. シートとレポートのURLをメールに送信する
  #
  # TODO: テスト実装
  def update
    # TODO: 以下の実装
    # インプットがシートなので、IDがパラメータで渡ってこないため
    # アップデートしようとすると全てインサートになる。
    # アップデートする前に、関連レコードを全消しする。
    if @sheet.update(sheet_params)
      # TODO: serializer実装。何を返すかはTBD。
      render_remined
    else
      render json: @sheet.errors, status: :unprocessable_entity
    end
  rescue => e
    goodbye(e)
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
      render serializer_json, status: :ok
    end

    def serializer_json
      {
        json: @sheet, 
        root: :data, 
        serializer: 
        SheetSerializer, 
      }
    end
end
