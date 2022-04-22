require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question, :with_options) }
  describe 'attributes' do
    it 'contains title' do
      question = build(:question)
      expect(question).to respond_to(:title)
    end
  end
  describe 'presence of attributes value' do
    it 'title should  value' do
      expect(subject).to be_valid
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
  describe 'association' do
    it 'should have many options' do
      question = build(:question, :with_options)
      expect(question).to be_valid
    end
    it 'should have at least 3 option' do
      question = build(:question, :with_options, option_count: 5)
      expect(question).to be_valid
      question = build(:question, :with_options, option_count: 2)
      expect(question).to_not be_valid
    end
    it 'should belongs to more categories' do
      question = build(:question, :with_categories)
      expect(question.categories.length).to be > 1
    end
  end
end
# it 'title should presence value' do
# question= build(:question).with_options
# end

# subject { build(:question, options: options) }

# describe 'attributes' do
#   it 'has title' do
#     expect(subject).to respond_to(:title)
#   end
# end
# describe 'attributes value' do
#   it 'title should presence value ' do
#     expect(subject).to be_valid
#     subject.title = nil
#     expect(subject).to_not be_valid
#   end
# end
