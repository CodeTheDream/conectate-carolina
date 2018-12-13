RSpec.describe WebsitesController, type: :controller do
  let(:admin)        { create :user, :admin }
  let(:agency)       { create :agency }
  let(:website)      { create :website, :agency, :website_type }
  let(:website_type) { create :website_type }

  before :each do
    sign_in admin
  end

  describe 'POST websites#create' do
    let(:valid_website) do
      post :create, params: {
        locale: 'en',
        website: {
          url: 'www.facebook.com',
          agency_id: agency,
          website_type_id: website_type
        }
      }
    end

    context 'when valid website attributes' do
      it 'redirects to websites_path on successful save' do
          valid_website
          expect(response).to redirect_to(websites_path)
      end

      it 'changes the website count on successful save' do
        expect { valid_website }.to change(Website, :count).by(1)
      end
    end

    context 'when invalid website attributes' do
      it 'renders new page on failed save' do
        post :create, params: {
          locale: 'en',
          website: {
            url: " ",
            agency_id: " ",
            website_type_id: " "
          }
        }
        expect(response).to render_template("new")
      end
    end

  end

  describe 'GET websites#show' do

    it 'should render show template' do
      get :show, params: { id: website, locale: 'en' }
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  # DESTROY SPECS
  describe 'DELETE websites#destroy' do
    before { @website = create :website, :agency, :website_type }

    it 'changes website count on destroy' do
      expect do
          delete :destroy, params: { id: @website, locale: 'en' }
      end.to change(Website, :count).by(-1)

    end

    it "redirects to websites_path after destroy" do
        delete :destroy, params: { id: @website, locale: 'en' }
        expect(response).to redirect_to(websites_path)
    end
  end
end
