require 'rails_helper'

RSpec.describe Faq, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:pregunta) }
    it { should validate_presence_of(:respuesta) }
  end
end
