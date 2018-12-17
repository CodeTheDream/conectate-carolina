require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class }
  let(:current_user) { create :user }
  let(:admin) { create :user, :admin, email: "conectateadmin@example.com" }

  # Only admins are permitted to access index and show
  permissions :index?, :show? do
    it 'does not allow access if not an admin' do
      expect(subject).not_to permit(current_user)
    end

    it 'allows access if an admin' do
      expect(subject).to permit(admin)
    end
  end

  # These permissions are unique to admins only. We want to prevent regular users from accessing them.
  permissions :update?, :destroy? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user)
    end
    it 'allows access if an admin' do
      expect(subject).to permit(admin)
    end
  end

end
