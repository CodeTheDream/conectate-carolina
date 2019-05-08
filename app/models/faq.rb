class Faq < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
  validates :pregunta, presence: true
  validates :respuesta, presence: true
  
  def new_faq_hash 
    { question: self.question, answer: self.answer, pregunta: self.pregunta, respuesta: self.respuesta }
  end
end
