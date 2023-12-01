require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  let!(:products) do
    [
      Product.create!(name: 'Small Box', type: 'Box', length: 10, width: 10, height: 10, weight: 5),
      Product.create!(name: 'Medium Box', type: 'Box', length: 20, width: 20, height: 20, weight: 15),
      Product.create!(name: 'Large Box', type: 'Box', length: 35, width: 35, height: 35, weight: 30)
    ]
    end
  let(:product_id) { products.first.id }
  
  # GET /products
  describe 'GET /products' do
    before { get '/products' }

    it 'returns products' do
      expect(response_json).not_to be_empty
      expect(response_json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /products/find_by_dimensions
  describe 'GET /products/find_by_dimensions' do
    context 'when the product exists' do
      before { get '/products/find_by_dimensions', params: { length: 10, width: 10, height: 10, weight: 5 } }

      it 'returns the product' do
        expect(response_json).not_to be_empty
        expect(response_json['name']).to eq(products.first.name)
        expect(response.body).to match(/Small Box/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the product does not exist' do
      before { get '/products/find_by_dimensions', params: { length: 99, width: 99, height: 99, weight: 99 } }

      it 'returns an error message' do
        expect(response_json).not_to be_empty
        expect(response_json['error']).to eq('No products fit that sizing')
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # POST /products
  describe 'POST /products' do
    let(:valid_attributes) do
      { product: { name: 'Sample Product', type: 'Box', length: 10, width: 10, height: 10, weight: 5 } }
    end
    let(:invalid_attributes) do
      { product: { name: 'Error Product' } }
    end
    
    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a product' do
        expect(response_json['name']).to eq('Sample Product')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/products', params: invalid_attributes }

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # PUT /products/:id
  describe 'PUT /products/:id' do
    let(:valid_attributes) do
      { product: { name: 'Update Name' } }
    end

    context 'when the record exists' do
      before { put "/products/#{product_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to eq(response_json.to_json) # Assuming response_json is a hash
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # DELETE /products/:id
  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end