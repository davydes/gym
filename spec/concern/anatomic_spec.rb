require 'spec_helper'

shared_examples_for 'anatomic' do
  let(:model) { described_class.to_s.underscore.to_sym } # the class that includes the concern

  describe 'when create' do
    it 'should be valid by default' do
      anatomic = build(model)
      expect(anatomic).to be_valid
    end

    describe 'should be invalid' do
      it 'without alias' do
        anatomic = build(model, alias: nil)
        expect(anatomic).to be_invalid
        expect(anatomic.errors[:alias].size).to be > 0
      end
      it 'with wrong alias format' do
        anatomic = build(model, alias: 'wrong alias')
        expect(anatomic).to be_invalid
        expect(anatomic.errors[:alias].size).to be > 0
      end
      it 'with duplicated alias' do
        create(model, alias: 'example_alias')
        anatomic2 = build(model, alias: 'example_alias')
        expect(anatomic2).to be_invalid
        expect(anatomic2.errors[:alias].size).to be > 0
      end
      it 'without name' do
        anatomic = build(model, name: nil)
        expect(anatomic).to be_invalid
        expect(anatomic.errors[:name].size).to be > 0
      end
      it 'with too long name' do
        anatomic = build(model, name: 'a'*251)
        expect(anatomic).to be_invalid
        expect(anatomic.errors[:name].size).to be > 0
      end
      it 'with too long description' do
        anatomic = build(model, description: 'a'*8001)
        expect(anatomic).to be_invalid
        expect(anatomic.errors[:description].size).to be > 0
      end
    end
  end

  describe 'when save' do
    it 'should be transform alias to lower' do
      str = 'ExAmPle'
      anatomic = create(model, alias: str)
      expect(anatomic.alias).to be == str.downcase
    end
  end
end