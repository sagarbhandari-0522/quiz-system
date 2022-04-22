require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }
  describe 'attributes' do
    it 'contains name' do
      category = build(:category)
      expect(category).to respond_to(:name)
    end
  end
  describe 'attributes' do
    it 'name should  value' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
  describe 'association' do
    it 'has many question' do
      category = build(:category, :with_questions)
      expect(category.questions.length).to be > 1
    end
  end
end
