class SheetMailer < ApplicationMailer
  # TODO: [TBD]ちゃんとしたメールアドレスを設定
  default from: 'hoge@hoge.com'

  def send_sheet_and_report_url(sheet)
    @sheet = sheet

    mail(
      to: @sheet.email,
      # TODO: [TBD]ちゃんとしたタイトル
      subject: 'Sheet送ります'
    )
  end
end
