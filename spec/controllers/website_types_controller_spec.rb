RSpec.describe WebsiteTypesController, type: :controller do
  let(:website_type) { create :website_type }

  describe 'POST websites#create' do
    let(:valid_website_type) do
      post :create, params: {
        locale: 'en',
        website_type: {
          name: 'Facebook'
        }
      }
    end

    context 'when valid website_type attributes' do
      it 'redirects to websites_path on successful save' do
          valid_website_type
          expect(response).to redirect_to(root_path)
      end

      it 'changes the website_type count on successful save' do
        expect { valid_website_type }.to change(WebsiteType, :count).by(1)
      end
    end

    context 'when invalid valid_website_type attributes' do
      it 'renders new page on failed save' do
        post :create, params: {
          locale: 'en',
          website_type: {
            name: " "
          }
        }
        expect(response).to render_template("new")
      end
    end

  end

  describe 'GET website_types#show' do

    it 'should render show template' do
      get :show, params: { id: website_type, locale: 'en' }
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  # DESTROY SPECS
  describe 'DELETE website_types#destroy' do
    before { @website_type = create :website_type }

    it 'changes website_type count on destroy' do
      expect do
          delete :destroy, params: { id: @website_type, locale: 'en' }
      end.to change(WebsiteType, :count).by(-1)

    end

    it "redirects to root_path after destroy" do
        delete :destroy, params: { id: @website_type, locale: 'en' }
        expect(response).to redirect_to(root_path)
    end
  end
end
