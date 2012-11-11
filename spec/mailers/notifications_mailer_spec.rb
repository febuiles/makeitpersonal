require "spec_helper"

describe NotificationsMailer do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }

  context "#followed" do
    it "lets the user know when someone's following them" do
      NotificationsMailer.followed(follower, followed).deliver
      email = ActionMailer::Base.deliveries.last

      email.to.should == [followed.email]
      email.subject.should == "#{follower.username} is now following you on makeitpersonal"
      assert_match(/is now following you/, email.encoded)
    end
  end
end
