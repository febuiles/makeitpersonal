require 'spec_helper'

describe User do
  context "validations" do
    it "verify the username " do

      User.new(username: "foobuiles").should have(0).errors_on(:username)
      User.new(username: "foo_builes9").should have(0).errors_on(:username)
      User.new(username: "foob.uiles").should have(1).errors_on(:username)
      User.new(username: "foo-bar").should have(1).error_on(:username)
      User.new(username: "foo bar").should have(1).error_on(:username)
    end
  end

  describe "#blank_profile?" do
    it "returns true if all the profile fields are empty" do
      FactoryGirl.build(:user).blank_profile?.should be_true
      FactoryGirl.build(:user, :twitter => "@mahavishnu").blank_profile?.should be_false
    end
  end

  context "following" do
    let(:follower) { FactoryGirl.create(:user) }
    let(:followed) { FactoryGirl.create(:user) }

    describe "#follow" do
      it "does nothing if the user's already being followed" do
        follower.follow(followed)
        expect { follower.follow(followed) }.not_to change(follower.followed_users, :count)
      end

      it "follows the user" do
        follower.follow(followed)
        follower.reload.followed_users.should include(followed)
      end
    end

    describe "#unfollow" do
      it "does nothing if the user's already unfollowed" do
        follower.follow(followed)
        follower.unfollow(followed)
        expect { follower.unfollow(followed) }.not_to change(follower.followed_users, :count)
      end

      it "follows the user" do
        follower.follow(followed)
        follower.unfollow(followed)
        follower.reload.followed_users.should_not include(followed)
      end
    end

    describe "#follows?" do
      it "returns true if a user follows another user" do
        follower.follows?(followed).should be_false
        follower.follow(followed)
        follower.follows?(followed).should be_true
      end
    end
  end
end
