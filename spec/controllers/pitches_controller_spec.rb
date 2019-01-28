require 'rails_helper'

RSpec.describe V1::PitchesController, type: :controller do
  before do
    create :user
    create :pitch
  end

  let(:current_user) { User.last }
  let(:pitch) { Pitch.last }

  let(:valid_attributes) {
    {
      city: Faker::Address.city,
      address: Faker::Address.street_address,
      opening_hour: Faker::Number.between(6, 10),
      closing_hour: Faker::Number.between(16, 2)
    }
  }

  let(:invalid_attributes) {
    {
      city: nil,
      address: nil,
      opening_hour: nil,
      closing_hour: nil
    }
  }

  let(:valid_session) { authenticate(current_user, request) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: pitch.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Pitch" do
        expect {
          post :create, params: { pitch: valid_attributes }, session: valid_session
        }.to change(Pitch, :count).by(1)
      end

      it "renders a JSON response with the new pitch" do
        post :create, params: { pitch: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new pitch" do
        post :create, params: { pitch: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          city: Faker::Address.city,
          address: Faker::Address.street_address,
          opening_hour: Faker::Number.between(6, 10),
          closing_hour: Faker::Number.between(16, 2)
        }
      }

      it "updates the requested pitch" do
        pitch = Pitch.create! valid_attributes
        put :update, params: {id: pitch.to_param, pitch: new_attributes}, session: valid_session
        pitch.reload
        expect(JSON.parse(response.body)).to eq(JSON.parse(pitch.to_json))
      end

      it "renders a JSON response with the pitch" do
        pitch = Pitch.create! valid_attributes

        put :update, params: { id: pitch.to_param, pitch: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the pitch" do
        pitch = Pitch.create! valid_attributes

        put :update, params: {id: pitch.to_param, pitch: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pitch" do
      pitch = Pitch.create! valid_attributes
      expect {
        delete :destroy, params: {id: pitch.to_param}, session: valid_session
      }.to change(Pitch, :count).by(-1)
    end
  end

end
