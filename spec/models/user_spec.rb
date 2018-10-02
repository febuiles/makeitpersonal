require 'spec_helper'

describe User do
  context "validations" do
    it "verifies the username" do
      expect(User.create(username: "foobuiles").errors[:username].size).to eq(0)
      expect(User.create(username: "foo_builes9").errors[:username].size).to eq(0)
      expect(User.create(username: "foob.uiles").errors[:username].size).to eq(1)
      expect(User.create(username: "foo-bar").errors[:username].size).to eq(1)
      expect(User.create(username: "foo bar").errors[:username].size).to eq(1)
    end
  end

  describe "#blank_profile?" do
    it "returns true if all the profile fields are empty" do
      FactoryGirl.build(:user).blank_profile?.should be_truthy
      FactoryGirl.build(:user, :twitter => "@mahavishnu").blank_profile?.should be_falsey
    end
  end

  context "loves" do
    let(:user) { FactoryGirl.create(:user) }
    let(:song) { FactoryGirl.create(:song) }

    describe "#loves?" do
      it "returns true if the user loves the song" do
        user.love(song)
        expect(user.loves?(song)).to be_truthy
      end
    end

    describe "#loved_songs" do
      it "returns a list of loved songs" do
        Love.create!(:user_id => user.id, :song_id => song.id)
        user.loved_songs.should include(song)
      end
    end

    describe "#loves_received" do
      it "returns a list of the user's songs that have been loved by someone else" do
        user.love(song)
        song.user.reload.loves_received.should include(song)
      end

      it "doesn't repeat songs" do
        another_user = FactoryGirl.create(:user)
        user.love(song)
        another_user.love(song)
        song.user.loves_received.count.should == 1
      end
    end

    describe "#love" do
      it "adds a song to the list of loved songs" do
        user.love(song)
        user.loved_songs.should include(song)
      end

      it "does not allow a user to love his own songs" do
        song.user.love(song)
        song.user.loved_songs.should_not include(song)
      end

      it "does not allow a user to love a song multiple times" do
        user.love(song)
        user.love(song)
        song.lovers.should == [user]
      end
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
        followed.followers.should include(follower)
      end
    end

    describe "#unfollow" do
      it "does nothing if the user's already unfollowed" do
        follower.follow(followed)
        follower.unfollow(followed)
        expect { follower.unfollow(followed) }.not_to change(follower.followed_users, :count)
      end

      it "unfollows the user" do
        follower.follow(followed)
        follower.unfollow(followed)
        follower.reload.followed_users.should_not include(followed)
      end

      it "shouldn't delete the user" do
        follower.follow(followed)
        follower.unfollow(followed)
        expect { followed.reload }.not_to raise_error
      end
    end

    describe "#follows?" do
      it "returns true if a user follows another user" do
        follower.follows?(followed).should be_falsey
        follower.follow(followed)
        follower.follows?(followed).should be_truthy
      end
    end

    describe "#followers" do
      let(:another_follower) { FactoryGirl.create(:user) }

      it "returns a list of followers in descending order" do
        follower.follow(followed)
        another_follower.follow(followed)
        followed.reload.followers.should == [another_follower, follower]
      end
    end

    describe "#followed_users" do
      let(:another_followed) { FactoryGirl.create(:user) }

      it "returns a list of followed users in descending order" do
        follower.follow(followed)
        follower.follow(another_followed)
        follower.reload.followed_users.should == [another_followed, followed]
      end
    end

    describe "#timeline_songs" do
      before do
        FactoryGirl.create(:song, :user_id => followed.id)
        FactoryGirl.create(:song, :user_id => follower.id)
        FactoryGirl.create(:song, :user_id => followed.id, hidden: true)
        FactoryGirl.create(:song, :user_id => followed.id, hidden: true)
        follower.follow(followed)
      end

      it "returns all the songs the user has uploaded" do
        follower.songs.each do |song|
          follower.timeline_songs.should include(song)
        end
      end

      it "returns the visible songs that the followed_users have uploaded" do
        followed.songs.visible.each do |song, |
          follower.timeline_songs.should include(song)
        end
      end

      it "sorts the songs by descending date" do
        follower.timeline_songs.first.created_at.to_i.should be >= follower.timeline_songs.last.created_at.to_i
      end

      it "doesn't show followd_users' hidden songs" do
        followed.songs.hidden.each do |song, |
          follower.timeline_songs.should_not include(song)
          song.should be_hidden
        end
      end
    end
  end
end
