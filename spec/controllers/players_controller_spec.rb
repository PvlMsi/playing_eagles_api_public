require 'rails_helper'

RSpec.describe V1::PlayersController, type: :controller do
  before do
    create :user
    create :player
    create :game
  end

  let(:current_user) { User.last }
  let(:player) { Player.last }

  let(:valid_attributes) {
    {
      user_id: current_user.id,
      game_id: Game.last.id,
      position: Faker::Number.between(0, 2)
    }
  }

  let(:invalid_attributes) {
    {
      user: nil,
      game: nil,
      position: nil
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
      get :show, params: { id: player.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Player" do
        expect {
          post :create, params: { player: valid_attributes }, session: valid_session
        }.to change(Player, :count).by(1)
      end

      it "renders a JSON response with the new player" do
        post :create, params: { player: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new player" do
        post :create, params: { player: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          position: Faker::Number.between(0,2)
        }
      }

      it "updates the requested player" do
        put :update, params: { id: player.to_param, player: new_attributes }, session: valid_session
        player.reload
        expect(JSON.parse(response.body)).to eq(JSON.parse(player.to_json))
      end

      it "renders a JSON response with the player" do
        player = Player.create! valid_attributes

        put :update, params: {id: player.to_param, player: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the player" do
        put :update, params: { id: player.to_param, player: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested player" do
      player = Player.create! valid_attributes
      expect {
        delete :destroy, params: {id: player.to_param}, session: valid_session
      }.to change(Player, :count).by(-1)
    end
  end

end
