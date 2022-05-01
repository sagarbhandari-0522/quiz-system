# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Category, type: :model) do
  subject { build(:category) }
  describe 'attributes' do
    it 'contains name' do
      category = build(:category)
      expect(category).to(respond_to(:name))
    end
  end
  describe 'association' do
    it { should have_many(:questions) }
  end

  describe 'validation' do
    it 'should have name' do
      expect(subject).to(be_valid)
    end
    it 'should not accept without name' do
      subject.name = nil
      expect(subject).to_not(be_valid)
    end
  end
end
