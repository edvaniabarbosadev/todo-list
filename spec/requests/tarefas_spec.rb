require 'rails_helper'

RSpec.describe 'Tarefas API' do
  # Initialize the test data
  let!(:grupo) { create(:grupo) }
  let!(:tarefas) { create_list(:tarefa, 20, grupo_id: grupo.id) }
  let(:grupo_id) { grupo.id }
  let(:id) { tarefas.first.id }

  # Test suite for GET /grupos/:grupo_id/tarefas
  describe 'GET /grupos/:grupo_id/tarefas' do
    before { get "/grupos/#{grupo_id}/tarefas" }

    context 'when grupo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all grupo tarefas' do
        expect(json.size).to eq(20)
      end
    end

    context 'when grupo does not exist' do
      let(:grupo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Grupo/)
      end
    end
  end

  # Test suite for GET /grupos/:grupo_id/tarefas/:id
  describe 'GET /grupos/:grupo_id/tarefas/:id' do
    before { get "/grupos/#{grupo_id}/tarefas/#{id}" }

    context 'when grupo tarefa exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the tarefa' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when grupo tarefa does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tarefa/)
      end
    end
  end

  # Test suite for PUT /grupos/:grupo_id/tarefas
  describe 'POST /grupos/:grupo_id/tarefas' do
    let(:valid_attributes) { { nome: 'Visit Narnia', concluida: false } }

    context 'when request attributes are valid' do
      before { post "/grupos/#{grupo_id}/tarefas", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/grupos/#{grupo_id}/tarefas", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Nome can't be blank/)
      end
    end
  end

  # Test suite for PUT /grupos/:grupo_id/tarefas/:id
  describe 'PUT /grupos/:grupo_id/tarefas/:id' do
    let(:valid_attributes) { { nome: 'Mozart' } }

    before { put "/grupos/#{grupo_id}/tarefas/#{id}", params: valid_attributes }

    context 'when tarefa exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the tarefa' do
        updated_tarefa = Tarefa.find(id)
        expect(updated_tarefa.nome).to match(/Mozart/)
      end
    end

    context 'when the tarefa does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tarefa/)
      end
    end
  end

  # Test suite for DELETE /grupos/:id
  describe 'DELETE /grupos/:id' do
    before { delete "/grupos/#{grupo_id}/tarefas/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end