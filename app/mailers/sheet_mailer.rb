class SheetMailer < ApplicationMailer
  default from: 'hoge@hoge.com'

  def send_sheet_and_report_url(sheet)
    @sheet = sheet

    mail(
      to: @sheet.email,
      subject: 'Sheet送ります'
    )
  end
end
