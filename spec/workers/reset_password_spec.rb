require 'spec_helper'

describe Workers::ResetPassword do
  describe "#perform" do
    it "given a user id it sends the reset password instructions for that user" do
      expect {
        Workers::ResetPassword.new.perform(alice.id)
      }.to change(Devise.mailer.deliveries, :length).by(1)
    end

    it "correctly sets the message parameters" do
      Workers::ResetPassword.new.perform(alice.id)
      mail = Devise.mailer.deliveries.last
      mail.to.should == [alice.email]
      mail.body.should include("change your password")
    end
  end
end
