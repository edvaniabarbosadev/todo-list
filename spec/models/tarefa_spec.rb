require 'rails_helper'

RSpec.describe Tarefa, type: :model do
  it { should belong_to(:grupo) }
  it { should validate_presence_of(:nome) }
end
