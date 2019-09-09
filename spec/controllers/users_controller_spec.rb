require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  let(:default_params) { { params: { locale: 'en' } } } #default_params is a method here
  let(:admin) { create :user, :admin }
  let(:user)  { create :user }
  let(:test_user) { create :user, email: "test_user@example.com" }

  ## INDEX SPECS
  describe 'GET users#index' do
    context "when the user is logged in" do # logged-in
      context "when the user is an admin" do
        before { sign_in admin }
        it 'returns a success response' do
          get :index, default_params
          expect(response).to have_http_status(200)
        end
      end

      context "when the user is non-admin" do
        before { sign_in user }
        it 'returns a failure response' do
          get :index, default_params
          expect(response).to_not have_http_status(200)
          redirect_to root_url
        end
      end
    end

    context "when the user is not logged in" do # not logged-in
      it 'should not render users#index' do
        get :index, default_params #, params: { use_route: '/users' }
        expect(response).to_not have_http_status(200)
      end
    end
  end

# # SHOW SPECS
  describe 'GET users#show' do
    context "when logged in as admin" do
      before { sign_in admin }
      it 'returns a success response' do
        get :show, params: { id: test_user.id, locale: 'en' }
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in as non-admin" do
      before { sign_in user }
      it 'returns a failure response' do
        get :show, params: { id: test_user.id, locale: 'en' }
        expect(response).to_not have_http_status(:success)
      end
    end

    context "when logged in and accessing own profile" do
      before { sign_in test_user }
      it 'returns a success response' do
        get :show, params: { id: test_user.id, locale: 'en' }
        expect(response).to have_http_status(:success)
      end
    end
  end

# # DESTROY SPECS
  describe 'DELETE users#destroy' do
    context 'when logged in as admin' do
      #render_views # can't be inside before block or other test blocks
      before { @user = create :user }
      before { sign_in admin }
      it 'deletes a user' do
        expect do
          delete :destroy, params: { id: @user.id, locale: 'en' }
        end.to change(User, :count)
      end

      it 'redirects to users_path after update' do
        delete :destroy, params: { id: @user.id, locale: 'en' }
        expect(response).to redirect_to(users_url)
      end
    end
  end

# # UPDATE SPECS
  describe 'PUT users#update' do
    context 'when logged in as admin' do
      before { sign_in admin }
      context 'valid user attributes' do  # Valid attributes [:user, :vip, :admin]
        it 'does update a user' do
            put :update, params: { id: test_user.id, locale: 'en', user: { role: :vip } }
            test_user.reload
            expect(response).to redirect_to(users_url)
            expect(test_user.role).to eq("vip")
        end
      end

      context 'invalid user attributes' do  # Invalid attributes
        it 'does not update a user' do
          put :update, params: { id: test_user.id, locale: 'en', user: { role: :vips } }
          test_user.reload
          expect(test_user.role).to_not eq("vips")
        end
      end
    end
  end
end
