require "spec_helper"

describe Notifications do

  describe "reminder" do

    before(:each) do
      @reminder = Factory(:reminder)
      @mail = Notifications.remind(@reminder)
    end

    it 'no deliveries at the start of the test' do
      ActionMailer::Base.deliveries.should be_empty
    end

    it "renders the headers" do
      @mail.subject.should match("Erinnerung")
      @mail.to.should eq([@reminder.mentor.email])
      @mail.from.should eq(["futurekids@panter.ch"])
    end

    it "renders the body" do
      @mail.body.encoded.should match("Lieber")
      @mail.body.encoded.should match(@reminder.kid.name)
    end

    it "delivers the email" do
      @mail.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end

  end

end