class SheetMailer < ApplicationMailer
# ISSUED: https://github.com/zero2hero-jp/secbokapp-front/issues/28
  default from: 'hoge@hoge.com'

  def send_sheet_and_report_url(sheet)
    @sheet = sheet

    mail(
      to: @sheet.email,
# ISSUED: https://github.com/zero2hero-jp/secbokapp-front/issues/29
  default from: 'hoge@hoge.com'
      subject: 'Sheet送ります'
    )
  end
end
