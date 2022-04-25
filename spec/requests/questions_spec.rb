require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  include Devise::Test::IntegrationHelpers
  before { sign_in(user) }
  let(:user) { create :user, admin: true }
  let(:question) do
    category = create(:category)
    question = attributes_for(:question, category_ids: category.id,
                                         options_attributes: { '0' => { 'title' => 'A', 'correct' => '0',
                                                                        '_destroy' => '0' },
                                                               '1' => { 'title' => 'A', 'correct' => '0',
                                                                        '_destroy' => '0' },
                                                               '2' => { 'title' => 'A', 'correct' => '0',
                                                                        '_destroy' => '0' } })
  end
  describe 'GET /index' do
    it 'should get the categories' do
      get questions_path
      response.should have_http_status(200)
    end

    it 'should render index page' do
      get categories_path
      response.should render_template('index')
    end
  end
  describe 'POST/create' do
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
  describe 'GET/show' do
    it 'should show a question based on a question id ' do
      post '/questions', params: { question: question }
      get question_path(Question.first)
      response.should render_template('show')
    end
  end
  describe 'PATCH/update' do
    it 'should update a category by the provided data' do
      post '/questions', params: { question: question }
      patch "/questions/#{Question.first.id}", params: { question: { title: 'How do you do' } }
      c = Question.first
      expect(c.title.eql?('How do you do'))
    end
  end
  describe 'DELETE/destroy' do
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
