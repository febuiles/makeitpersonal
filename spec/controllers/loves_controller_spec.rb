require 'spec_helper'

describe LovesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:song) { FactoryGirl.create(:song) }
  before { sign_in user }

  describe "create" do
    before do
      mail = double
      allow(mail).to receive(:deliver)
      expect(NotificationsMailer).to receive(:loved).with(user, song) { mail }
    end

    it "creates a love" do
      post :create, { id: song.id, format: "js" }
      expect(user.reload.loved_songs).to include(song)
    end
  end

  describe "destroy" do
    it "removes a love" do
      user.love(song)
      delete :destroy, { id: song.id, format: "js" }
      expect(user.reload.loved_songs).not_to include(song)
    end
  end
end
