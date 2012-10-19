# -*- coding: utf-8 -*-
require "spec_helper"

describe WelcomeMailer do
  let(:user) { User.new(email:"foo@bar.com", username: "bartok")}
  it "sends the welcome email to the user" do
    WelcomeMailer.welcome(user).deliver
    email = ActionMailer::Base.deliveries.first

    email.to.should == ["foo@bar.com"]
    email.subject.should == "Hello from makeitpersonal"
    assert_match(/Hey #{user.username}/, email.encoded)
  end
end
