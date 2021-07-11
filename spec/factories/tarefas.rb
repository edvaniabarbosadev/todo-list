FactoryBot.define do
    factory :tarefa do
      nome { Faker::Movies::StarWars.character }
      concluida { false }
    end
  end