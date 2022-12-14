require 'googleauth'
require 'google/apis/drive_v3'

class SbaGoogleApiClient
  SCOPE = [
    'https://www.googleapis.com/auth/drive',
    'https://www.googleapis.com/auth/spreadsheets'
  ]

  # jsonファイルを使わずに以下の環境変数をconfig/application.rbからセットしている
  # GOOGLE_CLIENT_ID / GOOGLE_CLIENT_EMAIL / GOOGLE_ACCOUNT_TYPE / GOOGLE_PRIVATE_KEY
  def initialize
    @auth = Google::Auth::ServiceAccountCredentials.make_creds(
      scope: SCOPE
    )
    @auth.fetch_access_token!
  end

# AT_SEE: https://github.com/zero2hero-jp/SecBokApp-server/issues/4
  # 1. シートをコピーする
  # 2. コピーしたシートに、パラメーターで受け取ったemailで権限付与
  # 3. spread sheetにmaster.key使って署名いれる(ssにメタ情報セット欄あるか？)
  # 4. コピーしたsheetのidを返す
  def build(email:)
    drive = ::Google::Apis::DriveV3::DriveService.new
    drive.authorization = @auth
    
    # 疎通動作確認用コード
    #list_files = drive.list_files()
    #puts list_files

    return 'sample_sheet_id'
  end
end
