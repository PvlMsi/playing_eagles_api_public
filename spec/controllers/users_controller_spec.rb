require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) {
    {
      email: user.email,
      password: Faker::Crypto.md5
    }
  }

  let(:invalid_attributes) {
    {
      email: '',
      password: ''
    }
  }

  let(:valid_session) {
    authenticate(user, request)
  }

  describe "GET #index" do
    it "returns a success response when authorized" do
      get :index, session: authenticate(user, request)
      expect(response).to be_successful
    end

    it "returns 401 staus code when not authorized" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #show" do
    it "returns a success response when authorized" do
      get :show, params: { id: user.to_param }, session: valid_session
      expect(response).to be_successful
    end

    it "returns 401 staus code when not authorized" do
      get :show, params: { id: user.to_param }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(user.to_json(except: :password_digest))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          password: Faker::Crypto.md5,
          email: Faker::Internet.email,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          birth_date: Faker::Date.birthday(16, 80),
          phone_number: Faker::PhoneNumber.phone_number,
          city: Faker::Address.city,
          street: Faker::Address.street_name
        }
      }

      it "updates the requested user" do
        put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        user.reload
        expect(response.body).to eq(user.to_json(except: :password_digest))
      end

      it "renders a JSON response with the user" do
        put :update, params: { id: user.to_param, user: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: { id: user.to_param }, session: valid_session
      }.to change(User, :count).by(-1)
    end
  end
end
