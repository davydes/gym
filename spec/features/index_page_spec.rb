require 'rails_helper'

describe 'Index page', type: :feature do
  it 'has welcome string' do
    visit '/'
    expect(page).to have_content 'Добро пожаловать на ресурс'
  end
end