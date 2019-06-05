require 'rails_helper'

RSpec.describe MessagesController do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:message) { create :message }

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

end
