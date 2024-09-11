require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns a successful response and renders the home template" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:home)
    end
  end
end
