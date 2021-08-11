require 'rails_helper'

describe Api::V1::RecipesController do
  describe '[GET] #index' do
    before do
      create_list(:recipe, 5)
      get :index
    end

    it 'returns all recipes' do
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end

  describe '[GET] #show' do
    let!(:recipe) { create(:recipe) }
    let(:expected_response) { RecipeSerializer.new(recipe).to_json }
    before do
      get :show, params: { id: recipe.to_param }
    end

    it 'returns requested recipe' do
      expect(response.body).to eq(expected_response)
    end
  end

  describe '[POST] #create' do
    let(:recipe_params) do
      {
        recipe: {
          name: 'Leczo',
          content: 'Very good dish'
        }
      }
    end

    context 'with valid params' do
      it 'creates recipe' do
        expect do
          post :create, params: recipe_params
        end.to change(Recipe, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'doesn\'t create recipe' do
        expect do
          post :create, params: { recipe: { name: '', content: '' } }
        end.not_to change(Recipe, :count)
      end
    end
  end

  describe '[PUT] #update' do
    let(:old_name) { 'Rosol' }
    let(:new_name) { 'Pierogi' }
    let(:recipe) { create(:recipe, name: old_name) }

    context 'with valid params' do
      it 'updates name' do
        expect do
          put :update, params: { id: recipe.id, recipe: { name: new_name } }
        end.to change { recipe.reload.name }.from(old_name).to(new_name)
      end

      it 'returns updated object' do
        put :update, params: { id: recipe.id, recipe: { name: new_name } }
        expect(JSON.parse(response.body)['name']).to eq(new_name)
      end
    end

    context 'with invalid params' do
      let(:invalid_new_name) { '' }

      it 'doesn\'t update name' do
        expect do
          put :update, params: { id: recipe.id, recipe: { name: invalid_new_name } }
        end.not_to change { recipe.reload.name }
      end
    end
  end

  describe '[DELETE] #destroy' do
    let!(:recipe) { create(:recipe) }

    it 'destroys the recipe' do
      expect { delete :destroy, params: { id: recipe.id } }.to change(Recipe, :count).by(-1)
    end

    it 'returns destroyed object' do
      delete :destroy, params: { id: recipe.id }
      expect(JSON.parse(response.body)['name']).to eq(recipe.name)
    end
  end
end
