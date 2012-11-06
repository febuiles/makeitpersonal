require 'spec_helper'

describe ApiRequest do

  describe "incr" do
    before { ApiRequest.incr }

    it "creates the endpoint DB entry if it doesn't exist" do
      ApiRequest.incr("/lyrics")
      ApiRequest.last.endpoint.should == "/lyrics"
    end

    it "increases the counter for the given endpoint" do
      expect { ApiRequest.incr("/lyrics") }.to change(ApiRequest, :entry_count).by(1)
    end

    it "defaults the endpoint to /lyrics" do
      expect { ApiRequest.incr }.to change(ApiRequest, :entry_count).by(1)
    end

    it "does not duplicate entries" do
      3.times { ApiRequest.incr }
      ApiRequest.find_all_by_endpoint("/lyrics").size.should == 1
    end
  end

  describe "entry_count" do
    before { ApiRequest.incr }

    it "returns the count for the given endpoint" do
      ApiRequest.entry_count("/lyrics").should == ApiRequest.find_by_endpoint("/lyrics").count
    end

    it "returns nil if the counter doesn't exist" do
      ApiRequest.entry_count("false").should be_nil
    end

    it "defaults the endpoint to /lyrics" do
      ApiRequest.entry_count.should == ApiRequest.find_by_endpoint("/lyrics").count
    end
  end
end
