require 'rails_helper'

describe 'Layout', type: :feature do
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

  context 'responsive layout', js: true do
    context 'when mobile' do
      before do
        resize_window_to_mobile
      end
      after do
        resize_window_default
      end

      it '#sidebar should be hidden' do
        visit '/'
        page.execute_script File.read(File.join(Rails.root, %w(vendor assets javascripts jquery.visible.js)))
        expect(page.evaluate_script('$(\'#sidebar\').visible()')).to eq false
      end

      it '#sidebar should be visible', driver: :chrome do
        visit '/'
        page.find('.navbar-header').find('button.navbar-toggle').click
        page.execute_script File.read(File.join(Rails.root, %w(vendor assets javascripts jquery.visible.js)))
        expect(page.evaluate_script('$(\'#sidebar\').visible()')).to eq true
      end
    end
  end
end
