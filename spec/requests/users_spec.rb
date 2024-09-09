require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe "POST /users" do
    it "creates a new user and redirects to the home page" do
      post user_registration_path, params: { 
        user: { 
          email: 'test@example.com', 
          password: '123123', 
          password_confirmation: '123123' 
        } 
      }

      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_path)
      follow_redirect!
    end

    it "fails with invalid data and renders the registration form again" do
      post user_registration_path, params: { 
        user: { 
          email: 'invalid-email',
          password: '123',
          password_confirmation: '123'
        } 
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Email is invalid")
      expect(response.body).to include("Password is too short")
    end
  end

  describe "GET /user/:id" do
    before do
      sign_in user
    end

    it "returns http success" do
      get user_path(other_user)
      expect(response).to have_http_status(:success)
    end

    it "renders the rooms/index template" do
      get user_path(other_user)
      expect(response).to render_template('rooms/index')
    end

    it "assigns the correct variables" do
      get user_path(other_user)
      expect(assigns(:user)).to eq(other_user)
      expect(assigns(:users)).to include(other_user)
      expect(assigns(:users)).not_to include(user)
      expect(assigns(:room)).to be_a_new(Room)
      expect(assigns(:single_room)).to be_present
      expect(assigns(:message)).to be_a_new(Message)
      expect(assigns(:messages)).to eq(assigns(:single_room).messages.order(:created_at))
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      sign_in user
    end

    it "signs out the user and redirects to the home page" do
      delete destroy_user_session_path
      
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_path)
      follow_redirect!
    end
  end
end
