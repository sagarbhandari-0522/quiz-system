# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Question, type: :model) do
  subject { build(:question, :with_options) }
  describe 'attributes' do
    it 'contains title' do
      question = build(:question)
      expect(question).to(respond_to(:title))
    end
  end

  describe 'association' do
    it { should have_many(:options) }
    it { should have_many(:categories) }
  end
  describe 'validation' do
    it 'should have title' do
      expect(subject).to(be_valid)
    end
    it 'should not accept without title' do
      subject.title = nil
      expect(subject).to_not(be_valid)
    end

    it 'should contain at least 3 option' do
      question = build(:question, :with_options, option_count: 5)
      expect(question).to(be_valid)
    end
    it 'should not accept with less than 3 options' do
      question = build(:question, :with_options, option_count: 2)
      expect(question).to_not(be_valid)
    end
  end
end
