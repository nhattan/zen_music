require "rails_helper"

RSpec.describe Transaction, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }

  let(:user) { FactoryGirl.create(:user) }

  describe "#update_user_plan_expires_in!" do
    before do
      @current_time = Time.current
    end
    context "plan_expires_in is nil" do
      it "adds correctly number of days to plan_expires_in" do
        allow(Time).to receive(:current).and_return(@current_time)
        transaction = FactoryGirl.create(:transaction, user: user)
        expect(user.plan_expires_in).to eq(Time.current + transaction.send(:duration))
      end
    end

    context "plan_expires_in is present" do
      context "plan_expires_in is greater than current time" do
        before do
          user.update plan_expires_in: @current_time + 1.month
        end
        it "adds correctly number of days to plan_expires_in" do
          allow(Time).to receive(:current).and_return(@current_time)
          transaction = FactoryGirl.create(:transaction, user: user)
          expect(user.plan_expires_in).to eq(Time.current + 1.month + transaction.send(:duration))
        end
      end

      context "plan_expires_in is less than current time" do
        before do
          user.update plan_expires_in: 2.days.ago
        end
        it "adds correctly number of days to plan_expires_in" do
          allow(Time).to receive(:current).and_return(@current_time)
          transaction = FactoryGirl.create(:transaction, user: user)
          expect(user.plan_expires_in).to  eq(Time.current + transaction.send(:duration))
        end
      end
    end
  end

  describe "#duration" do
    context "division remander is zero" do
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price)
        expect(transaction.send(:duration)).to eq 30.days
      end
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price*2)
        expect(transaction.send(:duration)).to eq 60.days
      end
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price*3)
        expect(transaction.send(:duration)).to eq 90.days
      end
    end

    context "division remander is non zero" do
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price.to_f*0.5)
        expect(transaction.send(:duration)).to eq 15.days
      end
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price.to_f*1.5)
        expect(transaction.send(:duration)).to eq 45.days
      end
      it do
        transaction = FactoryGirl.create(:transaction, user: user, amount: Setting.price.to_f*2.5)
        expect(transaction.send(:duration)).to eq 75.days
      end
    end
  end

  describe "#send_invoice!" do
    it "sends an email" do
      expect{ FactoryGirl.create(:transaction) }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
