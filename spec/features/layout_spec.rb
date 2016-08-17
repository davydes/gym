require 'rails_helper'

describe 'Layout', type: :feature, js: true do
  context 'when logged in as admin' do
    login(admin: true)
    it 'should have admin label' do
      visit '/'
      expect(page).to have_css 'strong.alert-danger', text: 'admin'
    end
  end

  context 'when logged in as user' do
    login(admin: false)
    it 'should have no admin label' do
      visit '/'
      expect(page).to have_no_css 'strong.alert-danger', text: 'admin'
    end
  end
end