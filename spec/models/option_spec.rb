# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Option, type: :model) do
  let(:question) { build(:question) }
  subject { build(:option, question: question) }

  describe 'attributes' do
    it 'has title' do
      expect(subject).to(respond_to(:title))
    end
    it 'has image' do
      expect(subject).to(respond_to(:image))
    end
  end
  describe 'association' do
    it { should belong_to(:question) }
  end

  describe 'validation' do
    it 'should have title' do
      expect(subject).to(be_valid)
    end
    it 'should not accept without title' do
      subject.title = nil
      expect(subject).to_not(be_valid)
    end

    it 'should not accept without question' do
      subject.question = nil
      expect(subject).to_not(be_valid)
    end
    it 'contain file in jpg/jpeg/png format ' do
      expect(subject).to(be_valid)
    end
    it 'raises error on uploading pdf file ' do
      subject.image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/offer.pdf'))
      expect(subject).to_not(be_valid)
    end
    it 'not contain file of size more than 500KB' do
      subject.image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/high.png'))
      expect(subject).to_not(be_valid)
    end
  end
end
