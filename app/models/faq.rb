class Faq < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
  validates :pregunta, presence: true
  validates :respuesta, presence: true
end
