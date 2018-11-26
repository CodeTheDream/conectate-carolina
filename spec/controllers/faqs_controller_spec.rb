require 'rails_helper'

RSpec.describe FaqsController, type: :controller do
  before do
    @admin = create :user, :admin
    @faq = create :faq
    @faq2 = create :faq
  end

  # INDEX SPECS
  describe 'GET faqs#index' do

    it 'should return a list of faqs' do
      get :index, params: { use_route: "/faqs" }
      expect(Faq.all).to eq([@faq, @faq2])
      expect(Faq.count).to eq(2)
    end
  end

  # SHOW SPECS
  describe 'GET faqs#show' do

    it 'should render show template' do
      get :show, params: { use_route: "/faqs", id: @faq}
      expect(response).to have_http_status(:success)
      expect(response).to render_template("show")
    end
  end

  # CREATE SPECS
  describe 'POST faqs#create' do
    before { sign_in @admin }
    let(:faq) { post :create, params: { use_route: "/faqs", faq: {
                  question: "What is CC?",
                  answer: "It's ...",
                  pregunta: "What is CC?",
                  respuesta: "It's ..."}
                }
              }
    it 'redirects to faqs_path on successful save' do
      expect(faq).to redirect_to(faqs_path)
    end

    it 'changes the faqs count on successful save' do
      expect { faq }.to change(Faq, :count).by(1)
    end
  end

  # UPDATE SPECS
  describe 'PUT faqs#update' do
    before { sign_in @admin }

    it 'updates a faq and redirects to faqs_path' do
      put :update, params: { id: @faq, locale: 'en', faq: { question: "What is Connectate Carolina?" } }
      @faq.reload
      expect(@faq.question).to eq("What is Connectate Carolina?")
      expect(response).to redirect_to(faqs_path)
    end
  end

  # DESTROY SPECS
  describe 'DELETE faqs#destroy' do
    before { sign_in @admin }
    let(:faq) {delete :destroy, params: { id: @faq, locale: 'en' }}

    it 'changes faq count on destroy' do
      expect { faq }.to change(Faq, :count).by(-1)
    end

    it "flashes a success message" do
      faq
      expect(flash[:success]).to match("Question Deleted")
    end

    it "redirects to faq_url(faqs_path) after destroy" do
        faq
        expect(response).to redirect_to(faqs_path)
    end
  end

end
