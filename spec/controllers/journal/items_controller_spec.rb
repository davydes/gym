require 'rails_helper'

RSpec.describe Journal::ItemsController, type: :controller do
  let (:journal) { create :journal, user: create(:user, confirmed_at: Time.zone.now) }

  context 'HTTP' do
    context 'when logged in as journal owner' do
      before :each do
        sign_in journal.user
      end

      context 'GET index' do
        it 'assigns nil @items' do
          item = create :journal_item, :with_workout, journal: journal
          get :index
          expect(assigns(:items)).to be_nil
        end
        it 'render template' do
          get :index
          expect(response).to render_template('journal/items/index')
        end
      end
    end

    context 'when logged out' do
      context 'GET index' do
        it 'should redirect to sign_in page' do
          get :index
          expect(response).to redirect_to('/users/sign_in')
        end
      end
    end

  end

  context 'JSON' do
    before :each do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'when logged in as journal owner' do
      before :each do
        sign_in journal.user
      end

      context 'GET index' do
        it 'assigns @items' do
          item = create :journal_item, :with_workout, journal: journal
          get :index
          expect(assigns(:items)).to eq([item])
        end
      end

      context 'GET show' do
        it 'assigns @item' do
          item = create :journal_item, :with_workout, journal: journal
          get :show, id: item.id
          expect(assigns(:item)).to eq(item)
        end
      end

      context 'POST create' do
        it 'should create valid item' do
          params = {
            executed_at: Time.now.to_i,
            workout_attributes: {
              name: 'Test',
              items_attributes: [
                {
                  exercise_id: create(:exercise).id,
                  pos: 1,
                  sets: [
                    { repeats: 1, weight: 1 }
                  ]
                }
              ]
            }
          }
          expect{ post :create, params }.to change{Journal::Item.count}.by(1)
          expect(response.status).to eq(201)
        end
      end

      context 'PUT update' do
        it 'should update item' do
          item = create :journal_item, :with_workout, journal: journal
          params = {
              id: item.id,
              executed_at: Time.now.to_i,
              workout_attributes: {
                  name: 'Test',
                  items_attributes: [
                      {
                          exercise_id: create(:exercise).id,
                          pos: 1,
                          sets: [
                              { repeats: 1, weight: 1 }
                          ]
                      }
                  ]
              }
          }
          put :update, params
          expect(response.status).to eq(204)
        end
      end

      context 'DELETE destroy' do
        it 'should destroy item' do
          item = create :journal_item, :with_workout, journal: journal
          expect{ delete :destroy, id: item.id }.to change{Journal::Item.count}.by(-1)
          expect(response.status).to eq(204)
        end
      end
    end

    context 'when logged out' do
      let (:item) { create :journal_item, :with_workout, journal: journal}
      context 'GET index' do
        it 'should get error' do
          get :index
          expect(JSON.parse(response.body).keys).to eq(['error'])
          expect(response.status).to eq(401)
        end
      end
      context 'GET show' do
        it 'should get error' do
          get :show, id: item.id
          expect(JSON.parse(response.body).keys).to eq(['error'])
          expect(response.status).to eq(401)
        end
      end
      context 'POST create' do
        it 'should get error' do
          post :create
          expect(JSON.parse(response.body).keys).to eq(['error'])
          expect(response.status).to eq(401)
        end
      end
      context 'PUT update' do
        it 'should get error' do
          put :update,  id: item.id
          expect(JSON.parse(response.body).keys).to eq(['error'])
          expect(response.status).to eq(401)
        end
      end
      context 'DELETE destroy' do
        it 'should get error' do
          delete :destroy, id: item.id
          expect(JSON.parse(response.body).keys).to eq(['error'])
          expect(response.status).to eq(401)
        end
      end
    end
  end
end