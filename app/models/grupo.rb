class Grupo < ApplicationRecord
	has_many :tarefas, dependent: :destroy

  validates_presence_of :nome
end
