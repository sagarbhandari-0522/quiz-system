require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:question) { build(:question) }
  subject { build(:option, question: question) }

  describe 'attributes' do
    it 'has title' do
      expect(subject).to respond_to(:title)
    end
  end
  describe 'association' do
    it { should belong_to(:question) }
  end

  describe 'validation' do
    it 'should have title' do
      expect(subject).to be_valid
    end
    it 'should not accept without title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'should associated with question' do
      expect(subject).to be_valid
    end
    it 'should not accept without question' do
      subject.question = nil
      expect(subject).to_not be_valid
    end
  end
end
