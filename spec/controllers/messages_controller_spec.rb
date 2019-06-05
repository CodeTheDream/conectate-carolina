require 'rails_helper'

RSpec.describe MessagesController do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }

  describe "GET #index" do
    subject { get :index, params: { locale: 'en'} }

    context "when logged in as non-admin" do
      before { sign_in user }
      it "does not render the index template" do
        expect(subject).to redirect_to root_path
        expect(flash.alert).to eq 'Access denied'
      end
    end

    context "when logged in as admin" do
      before { sign_in admin }
      it "renders the index template" do
        expect(subject).to render_template(:index)
      end
    end
  end

end
