require "rails_helper"

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  describe "#plan_is_expired?" do
    context "plan_expires_in is nil" do
      before do
        user.update plan_expires_in: nil
      end
      it "is not expired" do
        expect(user.plan_is_expired?).to be false
      end
    end

    context "plan_expires_in is less than current time" do
      before do
        user.update plan_expires_in: 1.second.ago
      end
      it "is expired" do
        expect(user.plan_is_expired?).to be true
      end
    end

    context "plan_expires_in is equal to current time" do
      before do
        @current_time = Time.current
        user.update plan_expires_in: @current_time
      end
      it "is expired" do
        expect(user.plan_is_expired?).to be true
      end
    end

    context "plan_expires_in is greater than current time" do
      before do
        user.update plan_expires_in: 1.second.from_now
      end
      it "is expired" do
        expect(user.plan_is_expired?).to be false
      end
    end
  end

  describe "#send_confirmation_email" do
    it "sends an email" do
      expect{ FactoryGirl.create(:user) }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "#eligible?" do
    context "user is normal user" do
      before do
        user.normal_user!
      end
      context "user plan is expired" do
        before do
          allow(user).to receive(:plan_is_expired?) { true }
        end
        it { expect(user.eligible?).to be false }
      end

      context "user plan is not expired" do
        before do
          allow(user).to receive(:plan_is_expired?) { false }
        end
        it { expect(user.eligible?).to be true }
      end
    end

    context "user is special user" do
      before do
        user.special_user!
      end
      it { expect(user.eligible?).to be true }
    end

    context "user is admin" do
      before do
        user.admin!
      end
      it { expect(user.eligible?).to be true }
    end
  end
end
