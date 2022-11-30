require 'rails_helper'

RSpec.describe "Sheets", type: :request do
  describe "GET /sheets" do
    it "works! (now write some real specs)" do
      get sheets_path
      expect(response).to have_http_status(200)
    end
  end
end
