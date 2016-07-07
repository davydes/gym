require "rails_helper"

RSpec.describe StatisticsMailer, type: :mailer do
  describe 'StatisticsMailer.common' do
    before :context do
      create_list(:admin, 3)
    end
    let(:mail) { described_class.common.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Common Stats')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(User.all.where(admin: true).pluck(:email))
    end
  end
end
