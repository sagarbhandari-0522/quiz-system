# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Categories', type: :request) do
  include Devise::Test::IntegrationHelpers
  before { sign_in(user) }
  describe 'when request is performed with role admin' do
    let(:user) { create :user, role: 'admin' }
    context 'GET /index' do
      it 'can get the categories' do
        get categories_path
        response.should(have_http_status(200))
      end
      it 'match the categories of view' do
        category = create(:category)
        get categories_path
        expect(assigns(:categories)).to(eq([category]))
      end
      it 'can render index page' do
        get categories_path
        response.should(render_template('index'))
      end
    end
    context 'POST/create' do
      it 'can create category' do
        category = attributes_for(:category, name: 'sagar')
        post '/categories', params: { category: category }
        response.should(redirect_to(category_path(assigns(:category))))
      end
      it 'can not create category without name' do
        category = attributes_for(:category, name: nil)
        post '/categories', params: { category: category }
        response.should(have_http_status(:unprocessable_entity))
      end
      it 'can create category and increase count' do
        category = attributes_for(:category, name: 'sagar')
        expect Category.count == 0
        post '/categories', params: { category: category }
        expect Category.count == 1
      end
    end
    context 'GET/show' do
      it 'can show a category based on a category id ' do
        category = create(:category, name: 'Sports')
        get category_path(category)
        response.should(render_template('show'))
      end
    end
    context 'PATCH/update' do
      it 'should update a category by the provided data' do
        category = create(:category, name: 'Sports')
        patch "/categories/#{category.id}", params: { category: { name: 'hello' } }
        category = Category.first
        expect(category.name.eql?('hello'))
      end
    end
    context 'DELETE/destroy' do
      it 'should delete category of provided id' do
        category = create(:category)
        delete "/categories/#{category.id}"
        response.should(have_http_status(:see_other))
      end
      it 'should decrese the value of count on delete' do
        Category.count.should(eq(0))
        category = create(:category)
        Category.count.should(eq(1))
        delete "/categories/#{category.id}"
        Category.count.should(eq(0))
      end
      it 'non admin user can not delete category' do
        category = create(:category)
        user.role = 'user'
        delete "/categories/#{category.id}"
        response.body.should(eq('not allowed to destroy? this Category'))
      end
    end
  end
  describe 'when request is performed with role user' do
    let(:user) { create :user, role: 'user' }
    context 'GET/index' do
      it 'can get the categories' do
        get categories_path
        response.should(have_http_status(200))
      end
      it 'match the categories of view' do
        category = create(:category)
        get categories_path
        expect(assigns(:categories)).to(eq([category]))
      end
      it 'can render index page' do
        get categories_path
        response.should(render_template('index'))
      end
    end
    context 'POST/create' do
      it 'can not create category' do
        category = attributes_for(:category, name: 'sagar')
        post '/categories', params: { category: category }
        response.body.should(eq('not allowed to create? this Category'))
      end
    end
    context 'GET/show' do
      it 'can show a category based on a category id ' do
        category = create(:category, name: 'Sports')
        get category_path(category)
        response.should(render_template('show'))
      end
    end
    context 'PATCH/update' do
      it 'can not update category' do
        category = create(:category, name: 'Sports')
        patch "/categories/#{category.id}", params: { category: { name: 'hello' } }
        response.body.should(eq('not allowed to update? this Category'))
      end
    end
    context 'DELETE/destroy' do
      it 'can not delete category' do
        category = create(:category)
        user.role = 'user'
        delete "/categories/#{category.id}"
        response.body.should(eq('not allowed to destroy? this Category'))
      end
    end
  end
end
