require 'spec_helper'

shared_examples_for 'anatomic' do
  let(:model) { described_class.to_s.split('::').last.underscore.to_sym } # the class that includes the concern
  let(:anatomic) { build(model) }

  describe 'validation:' do
    it 'should be valid by default' do
      expect(anatomic).to be_valid
    end

    describe 'should be invalid' do
      context 'when attribute' do
        describe 'alias' do
          it 'is empty' do
            anatomic.alias = nil
            expect(anatomic).to be_invalid
            expect(anatomic.errors.messages.keys).to eq([:alias])
          end

          it 'has wrong format' do
            anatomic.alias = 'wrong alias'
            expect(anatomic).to be_invalid
            expect(anatomic.errors.messages.keys).to eq([:alias])
          end

          it 'already exists' do
            anatomic.alias = create(model, alias: 'example_alias').alias
            expect(anatomic).to be_invalid
            expect(anatomic.errors.messages.keys).to eq([:alias])
          end
        end

        describe 'name' do
          it 'is empty' do
            anatomic.name = nil
            expect(anatomic).to be_invalid
            expect(anatomic.errors.messages.keys).to eq([:name])
          end
          it 'too long' do
            anatomic.name = 'a'*251
            expect(anatomic).to be_invalid
            expect(anatomic.errors.messages.keys).to eq([:name])
          end
        end

        it 'description too long' do
          anatomic.description = 'a'*8001
          expect(anatomic).to be_invalid
          expect(anatomic.errors.messages.keys).to eq([:description])
        end
      end
    end
  end

  describe '#before_save' do
    it 'should be transform alias to lower' do
      str = 'ExAmPle'
      anatomic = create(model, alias: str)
      expect(anatomic.alias).to be == str.downcase
    end
  end
end