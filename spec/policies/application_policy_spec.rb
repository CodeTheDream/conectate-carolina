require 'rails_helper'

RSpec.describe ApplicationPolicy do

  subject { described_class }
  let(:current_user) { create :user }
  let(:record) { create :record }

  # Users are not permitted access to the index, create, update, destroy, new, or edit actions
  permissions :index?, :create?, :update?, :destroy?, :new?, :edit? do
    it 'does not allow access' do
      expect(subject).not_to permit(current_user)
    end
  end

end
