# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Quizzes', type: :request) do
  include Devise::Test::IntegrationHelpers
  before { sign_in(user) }
  describe 'when request is performed with role admin' do
    let(:user) { create :user, role: 'admin' }
    context 'GET /index' do
      it 'can get the quizzes' do
        get quizzes_path
        response.should(have_http_status(200))
      end
      it 'can render index page' do
        get quizzes_path
        response.should(render_template('index'))
      end
    end
    context 'GET/new' do
      it 'should raise error if no category is selected' do
        get new_quiz_path, params: { category_ids: [] }
        expect(flash[:error]).to(eq('Please Select at least One Category'))
      end

      it 'should fetch at most 8 questions' do
        category1 = create(:category)
        category2 = create(:category)
        get new_quiz_path, params: { category_ids: [' ', category1.id, category2.id] }
        Quiz.first.questions.count.should(eq(8))
      end
    end
  end
end
