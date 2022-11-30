class SheetMailer < ApplicationMailer
# AT_SEE: https://github.com/zero2hero-jp/SecBokApp-server/issues/28
  default from: 'tbd@zero2hero.jp'

  def send_sheet_and_report_url(sheet)
    @sheet = sheet

    mail(
      to: @sheet.email,
# AT_SEE: https://github.com/zero2hero-jp/SecBokApp-server/issues/29
      subject: 'Sheet送ります'
    )
  end
end
