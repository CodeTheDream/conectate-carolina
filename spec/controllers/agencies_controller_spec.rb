require 'rails_helper'

RSpec.describe AgenciesController, type: :controller do
  let(:location1)  { "201 W. Main St. Durham, NC 27701" } #Just a string, not a hash
  let(:location2)  { "Durham, NC" }     # Durham, NC
  let(:default_location) { "Raleigh, NC" } # Default location
  let(:admin) { create :user, :admin }
  let(:test_agency) { create :agency }

# # INDEX SPECS
  describe 'GET agencies#index' do
    before do
      @category = create :category
      @agency1 = create :agency, address: "7751 Brier Creek Pkwy", city: "Raleigh", state: "NC", categories: [@category] #Infosys
      @agency2 = create :agency, name: "Thoughtbot", address: "213 Fayetteville St", city: "Raleigh", state: "NC", categories: [@category]#Thoughtbot
      @agency3 = create :agency, name: "T. Outlets", address: "4000 Arrowhead Blvd", city: "Mebane", state: "NC", categories: [@category]# Tanger outlets
      @agency4 = create :agency, name: "Agency 4"
      @agency5 = create :agency, name: "LabCorp", address: "1447 York Ct", city: "Burlington", state: "NC", categories: [@category] # LabCorp
    end
    context 'when searched without category and location provided' do
      it 'should retrun list of agencies in 20mi from default location' do
          expect(Agency.near(default_location)).to match_array([@agency1, @agency2])
      end

      it 'should retrun list of agencies in 10mi from default location' do
          expect(Agency.near(default_location, 10)).to match_array([@agency2])
      end

      it 'should retrun list of agencies in 30mi from default location' do
          expect(Agency.near(default_location, 30)).to match_array([@agency1, @agency2, @agency4])
      end

      it 'should retrun list of agencies in 30mi from default location' do
          expect(Agency.near(default_location, 50)).to match_array([@agency1, @agency2, @agency3, @agency4])
      end
    end

    context 'when searched without category but location provided' do
      it 'should retrun list of agencies in 10mi from location provided' do
          expect(Agency.near(location2, 10)).to match_array([@agency1, @agency4])
      end

      it 'should retrun list of agencies in 30mi from location provided' do
          expect(Agency.near(location2, 30)).to match_array([@agency1, @agency2, @agency3, @agency4])
      end

      it 'should retrun list of agencies in 50mi from location provided' do
          expect(Agency.near(location2, 50)).to match_array([@agency1, @agency2, @agency3, @agency4, @agency5])
      end
    end

    context 'when searched with category but without location provided' do
      it 'should retrun list of agencies in 10mi from default location' do
          expect(Agency.search_name("Software").near(default_location, 10)).to match_array([@agency2])
      end

      it 'should retrun list of agencies in 30mi from default location' do
          expect(Agency.search_name("Software").near(default_location, 30)).to match_array([@agency1, @agency2])
      end

      it 'should retrun list of agencies in 50mi from default location' do
          expect(Agency.search_name("Software").near(default_location, 50)).to match_array([@agency1, @agency2, @agency3])
      end
    end

    context 'when searched with category and location provided' do
      it 'should retrun list of agencies in 10mi from location provided' do
          expect(Agency.search_name("Software").near(location2, 10)).to match_array([@agency1])
      end

      it 'should retrun list of agencies in 30mi from location provided' do
          expect(Agency.search_name("Software").near(location2, 30)).to match_array([@agency1, @agency2, @agency3])
      end

      it 'should retrun list of agencies in 50mi from location provided' do
          expect(Agency.search_name("Software").near(location2, 50)).to match_array([@agency1, @agency2, @agency3, @agency5])
      end

    end
  end

# # SHOW SPECS
  describe 'GET agencies#show' do
    let(:agency) { create :agency }
    it 'should return an angency' do
      get :show, params: { id: agency.id, locale: 'en' }
      expect(response).to render_template("show")
      expect(response).to have_http_status(:success)
    end
  end

# # CREATE SPECS
  describe 'POST agencies#create' do
    before { sign_in admin }
    let(:agency) { post :create, params: { use_route: '/agencies', agency: { name: "Ctd", website: {url: "www.ctd.com" } }}}
    let(:agency1) { post :create, params: { use_route: '/agencies', agency: { name: " " }}}

    context "when valid agency attributes" do
      it "redirects to agency_url on successful save" do
        expect(agency).to redirect_to(agency_url(Agency.last))
      end

      it 'changes the agencies count on successful save' do
        expect do
          agency
        end.to change(Agency, :count)
      end
    end

    context "when invalid agency attributes" do
      it "renders new_agency template on failed save" do
        expect(agency1).to render_template("new")
      end

      it 'does not change the agencies count on failed save' do
        expect do
          agency1
        end.to_not change(Agency, :count)
      end
    end
  end

# # UPDATE SPECS
  describe 'PUT agencies#update' do
    context 'when logged in as admin' do
      before { sign_in admin }

      context 'valid agency attributes' do  # Valid attributes [:user, :vip, :admin]
        it 'does update an agency' do
            put :update, params: {id: test_agency.id, locale: 'en', agency: { name: "Green Software", website: { '1' => '' }}}

            test_agency.reload
            expect(response).to redirect_to(agency_url)
            expect(test_agency.name).to eq("Green Software")
        end
      end

      context 'invalid agency attributes' do  # Valid attributes [:user, :vip, :admin]
        it 'does not update an agency' do
            put :update, params: {id: test_agency.id, locale: 'en', agency: { name: " ", website: { '1' => '' }}}
            expect(test_agency).to render_template("edit")
        end
      end
    end
  end

# # DESTROY SPECS
  describe 'DELETE agencies#destroy' do
    before { sign_in admin }
    before { @agency = create :agency }

    it 'changes agency count on destroy' do
      expect do
        delete :destroy, params: { id: @agency.id, locale: 'en' }
      end.to change(Agency, :count).by(-1)
    end

    it "redirects to agencies_url(@new_agency) after destroy" do
      delete :destroy, params: { id: @agency.id, locale: 'en' }
      expect(response).to redirect_to(new_agency_url)
    end

  end


# # IMPORT SPECS
  describe 'POST agencies#import' do
    before { sign_in admin }
    let(:csv) { fixture_file_upload('import/agencies.csv', 'text/csv')}

    it "changes agency count on successful file upload" do
      expect do
        post :import, params: { file: csv, locale: 'en' }
      end.to change(Agency, :count).by(3)
    end
  end
end
