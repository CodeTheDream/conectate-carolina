require 'rails_helper'

RSpec.describe MessagesController do
  render_views

  let!(:user) { create :user }
  let!(:admin) { create :user, :admin }
  let!(:message) { create :message }

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

  describe "POST #create" do
    before { sign_in admin }
    it "redirects to messages_path on successful save" do
      post :create, params: { locale: 'en',
                              message: { title: "Weather alert", body: "There is severe weather alert in Raleigh area",
                              message_type: "warning", titulo: "Alerta del clima",
                              cuerpo: "Hay alerta de clima severo en el área de Raleigh"
                              }}

      expect(response).to redirect_to(messages_path)
    end

    it "renders new message template on unsuccessful save" do #missing params `Title` here
      post :create, params: { locale: 'en',
                              message: { body: "There is severe weather alert in Raleigh area",
                              message_type: "warning", titulo: "Alerta del clima",
                              cuerpo: "Hay alerta de clima severo en el área de Raleigh"
                              }}
      expect(response).to render_template(:new)
    end
  end

  describe "PUT #update" do
    before { sign_in admin }

    it "redirects to messages_path on successful update" do #updating only `title`
      put :update, params: {id: message.id, locale: 'en', message: { title: "Announcement!" } }
      message.reload
      expect(response).to redirect_to(messages_path)
    end

    it "renders to edit messages template on unsuccessful update" do # `title` update with blank
      put :update, params: {id: message.id, locale: 'en', message: { title: " " } }
      message.reload
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    before { sign_in admin }

    it "redirects to messages_path on successful destroy" do
      delete :destroy, params: {id: message.id, locale: 'en'}
      expect(response).to redirect_to(messages_path)
    end

    it "changes the message count on successful destroy" do
      expect do
        delete :destroy, params: {id: message.id, locale: 'en'}
      end.to change(Message, :count)
    end
  end

  describe "PUT #post" do
    before do
      sign_in admin
      message.update(posted: false, posted_at: nil)
    end

    it "displays flash message `Message posted.`" do
      put :post, params: {id: message.id, locale: 'en', message: { posted: true, posted_at: Time.zone.now }}
      expect(flash.notice).to eq 'Message posted.'
    end
  end

  describe "PUT #unpost" do
    before { sign_in admin }

    it "displays flash message `Message unposted.`" do
      put :unpost, params: {id: message.id, locale: 'en', message: {posted: false}}
      expect(flash.notice).to eq 'Message unposted.'
    end
  end

end
