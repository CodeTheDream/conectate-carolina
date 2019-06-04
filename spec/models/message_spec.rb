require 'rails_helper'

RSpec.describe Message, type: :model do
  subject {
   described_class.new(title: "Anything", body: "Lorem ipsum",
                     message_type: "warning", titulo: "Titulo-sp", cuerpo: "Cuerpo-sp")
 }

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:message_type) }
    it { should validate_presence_of(:titulo) }
    it { should validate_presence_of(:cuerpo) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a body" do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a message_type" do
      subject.message_type = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a titulo" do
      subject.titulo = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a cuerpo" do
      subject.cuerpo = nil
      expect(subject).to_not be_valid
    end
  end
end
