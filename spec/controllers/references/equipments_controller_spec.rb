require 'rails_helper'

RSpec.describe References::EquipmentsController, type: :controller do
  let (:equipments) { create_list(:equipment, 5) }

  context 'JSON' do
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    describe 'GET #index' do
      describe 'responds equipments as json with' do
        it 'right count' do
          count = equipments.count
          get :index
          json = JSON.parse(response.body)
          expect(json.length).to eq(count)
        end

        it 'right format' do
          create(:equipment)
          get :index
          json = JSON.parse(response.body)
          expect(json.first.keys).to eq(%w(id name alias))
        end
      end
    end
  end
end
