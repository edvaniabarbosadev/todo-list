class Tarefa < ApplicationRecord
  belongs_to :grupo

  validates_presence_of :nome
end
