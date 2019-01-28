require 'rails_helper'

RSpec.describe 'Pitches', type: :request do
  describe 'GET /pitches' do
    before do
      create :user
    end

    it 'works when user authenticated' do
      command = AuthenticateUser.call(User.last.email, 'pass')
      get v1_pitches_path, headers: { Authorization: command.result }
      expect(response).to have_http_status(200)
    end

    it 'returns 500 when not authenticated' do
      get v1_pitches_path, headers: nil
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
