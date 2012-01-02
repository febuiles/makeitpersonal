require 'nokogiri'
require "last_fm/parser"

include LastFm

describe Parser do
  include Parser

  context "#time_from_row" do
    let(:row) { double }
    let(:time) { double(:value => double(:to_i => 1330837200)) }

    before do
      row.stub!(:attr).with("uts").and_return(time)
      Time.stub!(:now).and_return(Time.new(2012, 1, 1))
    end

    it "returns the row's time in a Time format" do
      time_from_row(row).should == Time.new(2012, 3, 4)
    end

    it "returns the current time if the time format is invalid" do
      time_from_row("something").should == Time.new(2012, 1, 1)
    end
  end
end
