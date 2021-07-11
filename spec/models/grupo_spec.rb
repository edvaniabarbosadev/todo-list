require 'rails_helper'

RSpec.describe Grupo, type: :model do
  it { should have_many(:tarefas).dependent(:destroy) }
  it { should validate_presence_of(:nome) }
end