require 'rails_helper'

RSpec.describe Journal, type: :model do
  let (:journal) { build :journal, :with_user }

  describe 'validations' do
    it { expect(journal).to be_valid }

    describe 'should be invalid when attribute' do
      describe 'user' do
        it ' is nil' do
          journal.user = nil
          expect(journal).not_to be_valid
          expect(journal.errors.keys).to be == [:user]
        end
      end
    end
  end
end