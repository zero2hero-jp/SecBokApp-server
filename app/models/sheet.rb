class Sheet < ApplicationRecord
  has_many :years, dependent: :destroy
  accepts_nested_attributes_for :years

  has_many :knowledges, dependent: :destroy
  accepts_nested_attributes_for :knowledges

  # シートを複製してIDをセット
  def build
    client = SbaGoogleApiClient.new
    self.spreadsheet_id = client.build(email: email)
  end
end
