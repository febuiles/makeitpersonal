require 'spec_helper'

describe User do
  context "validations" do
    it "verify the username " do
      User.new(username: "foobuiles").should have(0).errors_on(:username)
      User.new(username: "foo_builes9").should have(0).errors_on(:username)
      User.new(username: "foob.uiles").should have(1).errors_on(:username)
      User.new(username: "foo-bar").should have(1).error_on(:username)
    end
  end
end
