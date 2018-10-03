require "spec_helper"

describe NotificationsMailer do
  let(:origin) { FactoryGirl.create(:user) }
  let(:target) { FactoryGirl.create(:user) }
  let(:song) { FactoryGirl.create(:song, :user_id => target.id) }

  describe "#followed" do
    it "lets the user know when someone's following them" do
      NotificationsMailer.followed(origin, target).deliver
      email = ActionMailer::Base.deliveries.last

      expect(email.to).to eq([target.email])
      expect(email.subject).to eq("#{origin.username} is now following you on makeitpersonal")
      assert_match(/is now following you/, email.encoded)
    end
  end

  describe "#loved" do
    it "notifies the user of a new love on their songs" do
      NotificationsMailer.loved(origin, song).deliver
      email = ActionMailer::Base.deliveries.last

      expect(email.to).to eq([target.email])
      expect(email.subject).to eq("#{origin.username} loved one of your songs")
      assert_match(/loved your notes on/, email.body.decoded)
    end
  end
end
