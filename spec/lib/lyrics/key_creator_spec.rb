require 'fast_spec_helper'
require 'lyrics/key_creator'

include Lyrics
describe KeyCreator do
  let(:params) { { :artist => "foo", :title => "bar" } }

  context ".key_for" do
    it "returns the MD5 for the song" do
      KeyCreator.key_for(params).should == "3858f62230ac3c915f300c664312c63f"
    end

    it "returns nil for invalid keys" do
      KeyCreator.key_for({}).should be_nil
    end

    it "doesn't care about capitalizations or spaces" do
      key = KeyCreator.key_for({ :artist => "foo bar", :title => "bar foo" })
      other = KeyCreator.key_for({ :artist => "Foo   bar", :title => "bar    Foo" })
      key.should == other
    end
  end
end
