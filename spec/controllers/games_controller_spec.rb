require 'rails_helper'

RSpec.describe V1::GamesController, type: :controller do
  before do
    create :game
    create :pitch
    create :user
  end

  let(:game) { Game.last }

  let(:current_user) { User.last }

  let(:valid_attributes) {
    {
      pitch_id: Pitch.last.id,
      date: game.date,
      players_quantity: game.players_quantity,
      time_length: game.time_length,
      user_id: current_user.id
    }
  }

  let(:invalid_attributes) {
    {
      pitch_id: nil,
      date: nil,
      players_quantity: nil,
      time_length: nil,
      user_id: nil
    }
  }

  let(:valid_session) {
    authenticate(current_user, request)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: game.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, params: { game: valid_attributes }, session: valid_session
        }.to change(Game, :count).by(1)
      end

      it "renders a JSON response with the new game" do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new game" do
        post :create, params: { game: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          date: Faker::Date.forward(30),
          players_quantity: Faker::Number.between(5, 7),
          time_length: Faker::Number.between(45, 90)
        }
      }

      it "updates the requested game" do
        put :update, params: { id: game.to_param, game: new_attributes }, session: valid_session
        game.reload
        expect(JSON.parse(response.body)).to eq(JSON.parse(game.to_json))
      end

      it "renders a JSON response with the game" do
        put :update, params: { id: game.to_param, game: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the game" do
        put :update, params: { id: game.to_param, game: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      expect {
        delete :destroy, params: { id: game.to_param }, session: valid_session
      }.to change(Game, :count).by(-1)
    end
  end
end
