require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class }
  let(:current_user) { create :user }
  let(:admin) { create :user, :admin, email: "conectateadmin@example.com" }

  # Only admins are permitted to access index
  permissions :index? do
    it 'does not allow access if not an admin' do
      expect(subject).not_to permit(current_user)
    end

    it 'allows access if an admin' do
      expect(subject).to permit(admin)
    end
  end

  # Only admins and the current user looking at themselves can access show
  permissions :show? do
    it 'allows access if an admin' do
      expect(subject).to permit(admin, current_user)
    end

    it 'allows access if viewing self' do
      expect(subject).to permit(current_user, current_user)
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
