require "rails_helper"

RSpec.describe TransactionMailer, :type => :mailer do

  describe "#invoice_email" do
    let(:transaction) { FactoryGirl.create(:transaction) }
    let(:mail) { TransactionMailer.invoice_email(transaction) }

    it "has appropriate subject" do
      expect(mail.subject).to eq("Your invoice from <%= Setting.app_name %>")
    end

    it "sends from the default email" do
      expect(mail.from).to eq([ENV['DEFAULT_MAILER_SENDER']])
    end

    it "sends to the subscriber" do
      expect(mail.to).to eq([transaction.user.email])
    end

    it "includes hi" do
      expect(mail.body.encoded).to match("Hi #{transaction.user.email}")
    end

    it "includes invoice date" do
      expect(mail.body.encoded).to match(transaction.created_at.to_date.to_s)
    end

    it "includes transaction ID" do
      expect(mail.body.encoded).to match(transaction.id.to_s)
    end

    it "includes total" do
      expect(mail.body.encoded).to match(money_amount_in_vnd(transaction.amount))
    end

    it "includes valid until" do
      expect(mail.body.encoded).to match(transaction.user.plan_expires_in.to_date.to_s)
    end
  end
end
