require 'rails_helper'

RSpec.describe 'Grupos API', type: :request do
  # initialize test data
  let!(:grupos) { create_list(:grupo, 10) }
  let(:grupo_id) { grupos.first.id }

  # Test suite for GET /grupos
  describe 'GET /grupos' do
    # make HTTP get request before each example
    before { get '/grupos' }

    it 'returns grupos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /grupos/:id
  describe 'GET /grupos/:id' do
    before { get "/grupos/#{grupo_id}" }

    context 'when the record exists' do
      it 'returns the grupo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(grupo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:grupo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Grupo/)
      end
    end
  end

  # Test suite for POST /grupos
  describe 'POST /grupos' do
    # valid payload
    let(:valid_attributes) { { nome: 'Learn Elm' } }

    context 'when the request is valid' do
      before { post '/grupos', params: valid_attributes }

      it 'creates a grupo' do
        expect(json['nome']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /grupos/:id
  describe 'PUT /grupos/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/grupos/#{grupo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /grupos/:id
  describe 'DELETE /grupos/:id' do
    before { delete "/grupos/#{grupo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end