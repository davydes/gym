require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let (:pictures) { create_list(:picture, 5) }

  context 'JSON' do
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context 'when logged in as admin' do
      login(admin: true)

      describe 'GET #index' do
        it 'responds pictures as json' do
          count = pictures.count
          get :index
          json = JSON.parse(response.body)
          expect(json.length).to eq(count)
        end
      end

      describe 'POST #create' do
        it 'increase pictures count' do
          params = { picture: attributes_for(:picture) }
          expect{ post :create, params }.to change { Picture.count }.by 1
          expect(response).to be_success
        end
      end

      describe 'PUT #update' do
        it 'change name' do
          picture = pictures.first
          params = { id: picture.id, picture: { name: 'new_name' } }
          put :update, params
          picture.reload
          expect(response).to be_success
          expect(picture.name).to eq 'new_name'
        end
      end

      describe 'DELETE #destroy' do
        it 'decrease pictures count' do
          picture = pictures.first
          params = { id: picture.id }
          expect{ delete :destroy, params }.to change { Picture.count }.by -1
          expect(response).to be_success
        end
      end
    end

    context 'when logged in as user' do
      login(admin: false)

      describe 'GET #index' do
        it {
          expect { get :index }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'POST #create' do
        it {
          params = { picture: attributes_for(:picture) }
          expect { post :create, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'PUT #update' do
        it {
          picture = pictures.first
          params = { id: picture.id, picture: { name: 'new_name' } }
          expect { put :update, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'DELETE #destroy' do
        it {
          picture = pictures.first
          params = { id: picture.id }
          expect { delete :destroy, params }.to raise_error CanCan::AccessDenied
        }
      end
    end

  end

  context 'DEFAULT' do
    context 'when user not logged in' do
      describe 'GET #index' do
        it {
          get :index
          expect(response).to redirect_to '/users/sign_in'
        }
      end
    end

    context 'when logged in as user' do
      login(admin: false)

      describe 'GET #index' do
        it { expect { get :index }.to raise_error CanCan::AccessDenied }
      end

      describe 'POST #create' do
        it {
          params = { picture: attributes_for(:picture) }
          expect { post :create, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'PUT #update' do
        it {
          params = { id: pictures.first.id, picture: attributes_for(:picture) }
          expect { put :update, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'DELETE #destroy' do
        it {
          params = { id: pictures.first.id }
          expect { delete :destroy, params }.to raise_error CanCan::AccessDenied
        }
      end
    end

    context 'when logged in as admin' do
      login(admin: true)

      describe 'GET #index' do
        it {
          expect { get :index }.to raise_error ActionController::UnknownFormat
        }
      end

      describe 'POST #create' do
        it {
          params = { picture: attributes_for(:picture) }
          expect { post :create, params }.to raise_error ActionController::UnknownFormat
        }
      end

      describe 'PUT #update' do
        it {
          params = { id: pictures.first.id, picture: attributes_for(:picture) }
          expect { put :update, params }.to raise_error ActionController::UnknownFormat
        }
      end

      describe 'DELETE #destroy' do
        it {
          params = { id: pictures.first.id }
          expect { delete :destroy, params }.to raise_error ActionController::UnknownFormat
        }
      end
    end
  end

end
