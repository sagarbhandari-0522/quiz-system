# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Quiz, type: :model) do
  subject { build(:quiz, :with_questions, :with_categories, :with_user) }

  describe 'association' do
    it { should have_many(:questions) }
    it { should have_and_belong_to_many(:categories) }
  end
end
