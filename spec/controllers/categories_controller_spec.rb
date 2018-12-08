require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  before do
    @admin    = create :user, :admin, email: "new_email@example.com"
    @category = create :category
    @agency   = @category.agencies.create(name: "Agency")
    @agency2  = @category.agencies.create(name: "Agency 2")
    @category2 = create :category, name: "Education"
  end

  ## INDEX SPECS
  describe 'GET categories#index' do

    it 'should return a list of categories' do
      get :index, params: { use_route: "/categories", locale: 'en' }
      expect(Category.all).to match_array([@category, @category2])
      expect(@category.agencies.count).to eq(2)
    end
  end

  ## SHOW SPECS
  describe 'GET categories#show' do
    it 'should show list of agencies that belong to @category' do
      get :show, params: { use_route: "/categories", id: @category.id }
      expect(@category.agencies).to match_array([@agency, @agency2])
    end

    it "should render show template" do
      get :show, params: { use_route: "/categories", id: @category }
      expect(response).to render_template("show")
      expect(response).to have_http_status(:success)
    end
  end

  ## CREATE SPECS
  describe 'POST categories#create' do
    before { sign_in @admin }
    let(:category) { post :create, params: { use_route: '/categories', category: { name: "Health" }}}
    let(:category1) { post :create, params: { use_route: '/categories', category: { name: " " }}}
    context 'when valid attributes' do
      it "redirects to categories_path on successful save" do
        expect(category).to redirect_to(categories_path)
      end

      it 'changes the categories count on successful save' do
        expect do
          category
        end.to change(Category, :count).by(1)
      end
    end

    context 'when invalid attributes' do
      it "renders new_category template on failed save" do
        expect(category1).to render_template("new")
      end

      it 'does not change the categories count on failed save' do

        expect do
          category1
        end.to_not change(Category, :count)
      end
    end
  end

## UPDATE SPECS
  describe 'PUT categories#update' do
    context 'when logged in as admin' do
      before { sign_in @admin }
      let(:category) { put :update, params: { id: @category.id, locale: 'en', category: { name: "Lawyer" }}}
      let(:category2) { put :update, params: { id: @category.id, locale: 'en', category: { name: " " }}}

      context 'when valid attributes' do  # Valid attributes [:user, :vip, :admin]
        it 'does update a category' do
            category
            @category.reload
            expect(@category.name).to eq("Lawyer")
        end

        it 'redirects to @category_path' do
            category
            @category.reload
            expect(response).to redirect_to(category_path)
        end
      end

      context 'when invalid attributes' do  # Valid attributes
        it 'does not update a category' do
          category2
          expect(@category).to render_template("edit")
        end
      end
    end
  end

  # # DESTROY SPECS
    describe 'DELETE categories#destroy' do
      before { sign_in @admin }

      it 'changes category count on destroy' do
        expect do
          delete :destroy, params: { id: @category.id, locale: 'en' }
        end.to change(Category, :count).by(-1)
      end

      it "redirects to categories_url(@new_category) after destroy" do
        delete :destroy, params: { id: @category.id, locale: 'en' }
        expect(response).to redirect_to(new_category_url)
      end
    end
end
