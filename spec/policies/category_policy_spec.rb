require 'rails_helper'

RSpec.describe CategoryPolicy do

  subject { described_class }
  let(:current_user) { create :user }
  let(:admin) { create :user, :admin, email: "conectateadmin@example.com" }

  # We want all users to be able to access the index and show pages for our categories
  # Applies to both admins and regular users
  permissions :index?, :show? do
    it 'allows access if not an admin' do
      expect(subject).to permit(current_user)
    end

    it 'allows access if an admin' do
      expect(subject).to permit(admin)
    end
  end

  # These permissions are unique to admins only. We want to prevent regular users from accessing them.
  permissions :update?, :create?, :destroy? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user)
    end
    it 'allows access if an admin' do
      expect(subject).to permit(admin)
    end
  end

end
