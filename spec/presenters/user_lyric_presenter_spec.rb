require 'fast_spec_helper'
require 'action_view'
require_relative '../../app/presenters/user_lyric_presenter'

describe UserLyricPresenter do
  context "lyric parsing" do
    it "replaces asterisks with <em> tags" do
      lyric = double(:lyrics => "*oh noes!*")
      UserLyricPresenter.new(lyric).lyrics.should == "<em>oh noes!</em>"
    end

    it "works on multiline strings" do
      lyric = double(:lyrics => "oh noes!
here comes the *cop*")
      UserLyricPresenter.new(lyric).lyrics.should == "oh noes!<br/>here comes the <em>cop</em>"
    end
  end

  context "song title" do
    it "capitalizes the titles" do
      lyric = double(:artist => "modest mouse", :title => "dashboard")
      UserLyricPresenter.new(lyric).title.should == "Modest Mouse &ndash; Dashboard"
    end
  end

  context "song embed" do
    it "returns an empty string if the user doesn't add a video" do
      lyric = double(:youtube_url => nil)
      UserLyricPresenter.new(lyric).embed.should == nil
    end

    it "returns the youtube embed code if the user adds a valid video" do
      lyric = double(:youtube_url => "http://www.youtube.com/watch?v=-KTsXHXMkJA")
      embed = UserLyricPresenter.new(lyric).embed
      embed.should match(/www.youtube.com\/embed\/-KTsXHXMkJA/)
      embed.should match(/<iframe.*?<\/iframe>/)
    end

    it "returns nil if the url is invalid" do
      lyric = double(:youtube_url => "http://makeitpersonal.co")
      UserLyricPresenter.new(lyric).embed.should be_nil
    end
  end
end
