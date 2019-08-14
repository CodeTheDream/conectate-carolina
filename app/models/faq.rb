class Faq < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
  validates :pregunta, presence: true
  validates :respuesta, presence: true

  def new_faq_hash
    { id: self.id,
      question: { en: self.question, es: self.pregunta },
      answer: { en: self.answer, es: self.respuesta }
    }
  end
end
