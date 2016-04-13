require 'rails_helper'

RSpec.describe PictureLinksController, type: :controller do
  let (:pictureable) { create(:muscle, pictures: create_list(:picture, 5)) }

  context 'JSON' do
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context 'when logged in as admin' do
      login(admin: true)

      describe 'GET #index' do
        it 'responds pictures as json' do
          get :index, muscle_id: pictureable.id
          json = JSON.parse(response.body)
          expect(json.length).to eq(pictureable.pictures.count)
        end
      end

      describe 'POST #create' do
        it 'increase pictures count' do
          picture = create(:picture)
          params = { muscle_id: pictureable.id, l_id: picture.id }
          expect{ post :create, params }.to change { pictureable.pictures.count }.by 1
          expect(response).to be_success
        end
      end

      describe 'DELETE #destroy' do
        it 'decrease pictures count' do
          picture = pictureable.pictures.first
          params = { muscle_id: pictureable.id, id: picture.id }
          expect{ delete :destroy, params }.to change { pictureable.pictures.count }.by -1
          expect(response).to be_success
        end
      end
    end

    context 'when logged in as user' do
      login(admin: false)

      describe 'GET #index' do
        it {
          expect { get :index, muscle_id: pictureable.id }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'POST #create' do
        it {
          picture = create(:picture)
          params = { muscle_id: pictureable.id, l_id: picture.id}
          expect { post :create, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'DELETE #destroy' do
        it {
          picture = pictureable.pictures.first
          params = { muscle_id: pictureable.id, id: picture.id }
          expect { delete :destroy, params }.to raise_error CanCan::AccessDenied
        }
      end
    end

  end

  context 'DEFAULT' do
    context 'when user not logged in' do
      describe 'GET #index' do
        it {
          get :index, muscle_id: pictureable.id
          expect(response).to redirect_to '/users/sign_in'
        }
      end
    end

    context 'when logged in as user' do
      login(admin: false)

      describe 'GET #index' do
        it { expect { get :index, muscle_id: pictureable.id }.to raise_error CanCan::AccessDenied }
      end

      describe 'POST #create' do
        it {
          params = { muscle_id: pictureable.id, picture: attributes_for(:picture) }
          expect { post :create, params }.to raise_error CanCan::AccessDenied
        }
      end

      describe 'DELETE #destroy' do
        it {
          params = { muscle_id: pictureable.id, id: pictureable.pictures.first.id }
          expect { delete :destroy, params }.to raise_error CanCan::AccessDenied
        }
      end
    end

    context 'when logged in as admin' do
      login(admin: true)

      describe 'GET #index' do
        it {
          get :index, muscle_id: pictureable.id
          expect(response).to render_template('index')
        }

        it 'assigns pictures' do
          get :index, muscle_id: pictureable.id
          expect(assigns(:pictures)).to eq(pictureable.pictures)
        end
      end

      describe 'POST #create' do
        it {
          picture = create(:picture)
          params = { muscle_id: pictureable.id, l_id: picture.id}
          expect { post :create, params }.to raise_error ActionController::UnknownFormat
        }
      end

      describe 'DELETE #destroy' do
        it {
          params = { muscle_id: pictureable.id, id: pictureable.pictures.first.id }
          expect { delete :destroy, params }.to raise_error ActionController::UnknownFormat
        }
      end
    end
  end

end
