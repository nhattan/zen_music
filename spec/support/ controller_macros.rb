module ControllerMacros
  def login_admin
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user, role: :admin)
    end
  end

  def login_special_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user, role: :special_user)
    end
  end

  def login_nornal_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user, role: :normal_user)
    end
  end
end
