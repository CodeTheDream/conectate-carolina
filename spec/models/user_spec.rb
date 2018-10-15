require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Enum Macros" do
    it { should define_enum_for(:role) }
  end

  describe ".set_default_role" do

    role = ""

    context "User has no role" do
      it "should have a default role of 'user'" do
        user = build :user, name: "Test user", role: role
        user.set_default_role
        user.save
        user.role.should eq 'user'
      end
    end

  end

  describe 'email behavior' do
    before(:each) { @user = User.new(email: 'user@example.com') }
    subject { @user }

    it { should respond_to(:email) }

    it "#email returns a string" do
      expect(@user.email).to match 'user@example.com'
    end
  end
end
