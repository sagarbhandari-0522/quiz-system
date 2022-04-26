# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  include Devise::Test::IntegrationHelpers
  before { sign_in(user) }
  let(:question) do
    category = create(:category)
    options_params = { '0' => { 'title' => 'A', 'correct' => '0',
                                '_destroy' => '0' },
                       '1' => { 'title' => 'A', 'correct' => '0',
                                '_destroy' => '0' },
                       '2' => { 'title' => 'A', 'correct' => '0',
                                '_destroy' => '0' } }
    attributes_for(:question, category_ids: category.id,
                              options_attributes: options_params)
  end
  describe 'when request is performed with role admin' do
    let(:user) { create :user, role: 'admin' }

    context 'GET /index' do
      it 'should get the categories' do
        get questions_path
        response.should have_http_status(200)
      end

      it 'should render index page' do
        get categories_path
        response.should render_template('index')
      end
    end
    context 'POST/create' do
      it 'should create question' do
        post '/questions', params: { question: question }
        response.should redirect_to question_path(assigns(:question))
      end
      it 'should not create question without options' do
        category = create(:category)
        question = attributes_for(:question, category_ids: category.id)
        post '/questions', params: { question: question }
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should create question and increase count' do
        Question.count.should eq 0

        post '/questions', params: { question: question }
        # byebug
        Question.count.should eq 1
      end
    end
    context 'GET/show' do
      it 'should show a question based on a question id ' do
        post '/questions', params: { question: question }
        get question_path(Question.first)
        response.should render_template('show')
      end
    end
    context 'PATCH/update' do
      it 'should update a category by the provided data' do
        post '/questions', params: { question: question }
        patch "/questions/#{Question.first.id}", params: { question: { title: 'How do you do' } }
        question = Question.first
        expect(question.title.eql?('How do you do'))
      end
    end
    context 'DELETE/destroy' do
      it 'should delete question of provided id' do
        post '/questions', params: { question: question }
        delete "/questions/#{Question.first.id}"
        response.should have_http_status(:see_other)
      end

      it 'should delete question of provided id' do
        Question.count.should eq 0
        post '/questions', params: { question: question }
        Question.count.should eq 1
        delete "/questions/#{Question.first.id}"
        Question.count.should eq 0
      end
    end
  end
  describe 'when request is performed with role user' do
    let(:user) { create :user, role: 'user' }
    context 'GET /index' do
      it 'should get the categories' do
        get questions_path
        response.should have_http_status(200)
      end
    end
    context 'POST/create' do
      it 'cannot create question' do
        post '/questions', params: { question: question }
        response.body.should eq('not allowed to create? this Question')
      end
    end
    context 'GET/show' do
      it 'can show question based on a question id' do
        user.role = 'admin'
        post '/questions', params: { question: question }
        user.role = 'user'
        get question_path(Question.first.id)
        response.should render_template('show')
      end
    end
  end
end
