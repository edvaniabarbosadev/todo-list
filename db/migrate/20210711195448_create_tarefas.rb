class CreateTarefas < ActiveRecord::Migration[6.1]
  def change
    create_table :tarefas do |t|
      t.string :nome, limit: 50
      t.boolean :concluida
      t.references :grupo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
