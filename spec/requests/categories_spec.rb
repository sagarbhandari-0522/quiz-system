require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include Devise::Test::IntegrationHelpers
  before { sign_in(user) }
  let(:user) { create :user, admin: true }
  describe 'GET /index' do
    it 'should get the categories' do
      get categories_path
      response.should have_http_status(200)
    end
    it 'match the categories of view' do
      category = create(:category)
      get categories_path
      expect(assigns(:categories)).to eq([category])
    end
    it 'should render index page' do
      get categories_path
      response.should render_template('index')
    end
  end
  describe 'POST/create' do
    it 'should create category' do
      category = attributes_for(:category, name: 'sagar')
      post '/categories', params: { category: category }
      response.should redirect_to category_path(assigns(:category))
    end
    it 'should not create category without name' do
      category = attributes_for(:category, name: nil)
      post '/categories', params: { category: category }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should create category and increase count' do
      category = attributes_for(:category, name: 'sagar')
      expect Category.count == 0
      post '/categories', params: { category: category }
      expect Category.count == 1
    end
  end
  describe 'GET/show' do
    it 'should show a category based on a category id ' do
      category = create(:category, name: 'Sports')
      get category_path(category)
      response.should render_template('show')
    end
  end
  describe 'PATCH/update' do
    it 'should update a category by the provided data' do
      sign_in user
      category = create(:category, name: 'Sports')
      patch "/categories/#{category.id}", params: { category: { name: 'hello' } }
      c = Category.first
      expect(c.name.eql?('hello'))
    end
  end
  describe 'DELETE/destroy' do
    it 'should delete category of provided id' do
      category = create(:category)
      delete "/categories/#{category.id}"
      response.should have_http_status(302)
    end
  end
end
