require 'rails_helper'

RSpec.describe Journal::Item, type: :model do
  let (:item) { build :journal_item, :with_journal, :with_workout }

  describe 'validations' do
    it { expect(item).to be_valid }

    describe 'should be invalid when attribute' do
      it 'journal is nil' do
        item.journal = nil
        expect(item).not_to be_valid
        expect(item.errors.keys).to be == [:journal]
      end

      it 'workout is nil' do
        item.workout = nil
        expect(item).not_to be_valid
        expect(item.errors.keys).to be == [:workout]
      end

      describe :executed_at do
        it 'is nil' do
          item.executed_at = nil
          expect(item).not_to be_valid
          expect(item.errors.keys).to be == [:executed_at]
        end

        it 'from future' do
          item.executed_at = Time.now + 1.day
          expect(item).not_to be_valid
          expect(item.errors.keys).to be == [:executed_at]
        end
      end
    end
  end
end