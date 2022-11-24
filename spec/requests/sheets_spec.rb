require 'rails_helper'

RSpec.describe Api::V1::SheetsController, type: :request do
  describe 'GET /api/v1/sheets' do
    before { create_list(:sheet, 5) }
    it 'get all items' do
      is_expected.to eq 200
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(5)
    end
  end
end
