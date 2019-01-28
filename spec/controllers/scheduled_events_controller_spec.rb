require 'rails_helper'

RSpec.describe V1::ScheduledEventsController, type: :controller do
  before do
    create :user
    create :scheduled_event
    create :pitch
  end

  let(:current_user) { User.last }
  let(:scheduled_event) { ScheduledEvent.last }

  let(:valid_attributes) {
    {
      pitch_id: Pitch.last.id,
      date_from: Faker::Date.between(Date.today, 1.week.from_now),
      date_to: Faker::Date.between(1.week.from_now, 1.year.from_now),
      interval: Faker::Number.between(1, 10),
      interval_type: Faker::Number.between(0, 2),
      canceled: false
    }
  }

  let(:invalid_attributes) {
    {
      pitch: nil,
      date_from: nil,
      date_to: nil,
      interval: nil,
      interval_type: nil,
      canceled: nil
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
      get :show, params: { id: scheduled_event.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ScheduledEvent" do
        expect {
          post :create, params: { scheduled_event: valid_attributes }, session: valid_session
        }.to change(ScheduledEvent, :count).by(1)
      end

      it "renders a JSON response with the new scheduled_event" do
        post :create, params: {scheduled_event: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new scheduled_event" do
        post :create, params: {scheduled_event: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          pitch_id: Pitch.last.id,
          date_from: Faker::Date.between(Date.today, 1.week.from_now),
          date_to: Faker::Date.between(1.week.from_now, 1.year.from_now),
          interval: Faker::Number.between(1, 10),
          interval_type: Faker::Number.between(0, 2),
          canceled: Faker::Boolean.boolean(0.2)
        }
      }

      it "updates the requested scheduled_event" do
        put :update, params: { id: scheduled_event.to_param, scheduled_event: new_attributes }, session: valid_session
        scheduled_event.reload
        expect(JSON.parse(response.body)).to eq(JSON.parse(scheduled_event.to_json))
      end

      it "renders a JSON response with the scheduled_event" do
        put :update, params: { id: scheduled_event.to_param, scheduled_event: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the scheduled_event" do
        put :update, params: { id: scheduled_event.to_param, scheduled_event: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested scheduled_event" do
      scheduled_event = ScheduledEvent.create! valid_attributes
      expect {
        delete :destroy, params: { id: scheduled_event.to_param }, session: valid_session
      }.to change(ScheduledEvent, :count).by(-1)
    end
  end

end
