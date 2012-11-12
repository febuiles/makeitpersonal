require 'spec_helper'

describe LovesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:song) { FactoryGirl.create(:song) }
  before { sign_in user }

  describe "create" do
    before do
      mail = stub
      mail.should_receive(:deliver)
      NotificationsMailer.should_receive(:loved).with(user, song).and_return(mail)
    end

    it "creates a love" do
      post :create, { :id => song.id }
      user.reload.loved_songs.should include(song)
    end
  end

  describe "destroy" do
    it "removes a love" do
      user.love(song)
      delete :destroy, { :id => song.id }
      user.reload.loved_songs.should_not include(song)
    end
  end
end
