require "rails_helper"

RSpec.describe Transaction, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }

  let(:user) { FactoryGirl.create(:user) }

  describe "#update_user_plan_expires_in!" do
    context "plan_expires_in is nil" do
      it "adds correctly number of days to plan_expires_in" do
        transaction = FactoryGirl.create(:transaction, user: user)
        expect(user.plan_expires_in).to be > Time.current + transaction.send(:duration) - 5.seconds
      end
    end

    context "plan_expires_in is present" do
      before do
        user.update plan_expires_in: 32.days.from_now
      end
      it "adds correctly number of days to plan_expires_in" do
        transaction = FactoryGirl.create(:transaction, user: user)
        expect(user.plan_expires_in).to be > 32.days.from_now + transaction.send(:duration) - 5.seconds
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
end
