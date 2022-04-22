require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:question) { build(:question) }
  subject { build(:option, question: question) }

  describe 'attributes' do
    it 'has title' do
      expect(subject).to respond_to(:title)
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
    it 'should associated with question' do
      expect(subject).to be_valid
      subject.question = nil
      expect(subject).to_not be_valid
    end
  end
end
