require 'rails_helper'

RSpec.describe V1::OpinionsController, type: :controller do
  before do
    create :user
    create :player
    create :opinion
    create :game
  end

  let(:current_user) { User.last }
  let(:opinion) { Opinion.last }

  let(:valid_attributes) {
    {
      player_id: Player.last.id,
      game_id: Game.last.id,
      description: opinion.description,
      anonymous: opinion.anonymous,
      nice_rate: opinion.nice_rate,
      attitute_rate: opinion.attitute_rate,
      showed_up: opinion.showed_up
    }
  }

  let(:invalid_attributes) {
    {
      player_id: nil,
      game_id: nil,
      description: nil,
      anonymous: nil,
      nice_rate: nil,
      attitute_rate: nil,
      showed_up: nil
    }
  }

  let(:valid_session) {
    authenticate(current_user, request)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: opinion.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Opinion" do
        expect {
          post :create, params: { opinion: valid_attributes }, session: valid_session
        }.to change(Opinion, :count).by(1)
      end

      it "renders a JSON response with the new opinion" do

        post :create, params: { opinion: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new opinion" do

        post :create, params: {opinion: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          description: Faker::SiliconValley.quote,
          anonymous: Faker::Boolean.boolean(0.4),
          nice_rate: Faker::Number.between(1, 5),
          attitute_rate: Faker::Number.between(1, 5),
          showed_up: Faker::Boolean.boolean(0.7)
        }
      }

      it "updates the requested opinion" do
        put :update, params: { id: opinion.to_param, opinion: new_attributes }, session: valid_session
        opinion.reload
        expect(JSON.parse(response.body)).to eq(JSON.parse(opinion.to_json))
      end

      it "renders a JSON response with the opinion" do
        put :update, params: {id: opinion.to_param, opinion: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the opinion" do
        opinion = Opinion.create! valid_attributes

        put :update, params: {id: opinion.to_param, opinion: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested opinion" do
      expect {
        delete :destroy, params: {id: opinion.to_param}, session: valid_session
      }.to change(Opinion, :count).by(-1)
    end
  end
end
