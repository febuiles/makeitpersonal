# -*- coding: utf-8 -*-
require 'fast_spec_helper'
require 'song_persistable'
require 'last_fm/list'

module LastFm
  class List
    def initialize(user)
      @user = user.strip
      mock_document
    end
  end
end

describe SongPersistable do
  include SongPersistable

  context "#fetch_song" do
    let(:username) { "febuiles "}
    let(:start_date) { Time.at(1324579382) }
    let(:end_date) { Time.at(1324579609) }
    let(:song_list) { [1, 2, 3] }
    let(:songs) { [] }

    it "doesn't reassign songs" do
      songs.stub!(:blank?).and_return(false)
      self.should_not_receive(:songs=)
      fetch_songs
    end

    it "saves the songs as an array of JSON objects" do
      songs.stub!(:blank?).and_return(true)
      expected_songs = ["{\"artist\":\"Foals\",\"title\":\"Heavy Water\",\"art\":\"http://userserve-ak.last.fm/serve/34s/70521468.png\",\"time\":\"2011-12-22 13:46:49 -0500\"}", "{\"artist\":\"Alexisonfire\",\"title\":\"The Kennedy Curse\",\"art\":\"http://userserve-ak.last.fm/serve/34s/12774691.jpg\",\"time\":\"2011-12-22 13:43:02 -0500\"}"]
      self.should_receive(:songs=).with(expected_songs)
      fetch_songs
    end
  end
end
