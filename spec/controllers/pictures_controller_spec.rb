require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  describe "HTML format" do
    describe "GET index" do

      before (:context) do
        @pictureable = create(:muscle, pictures: create_list(:picture, 5))
        @pictures = @pictureable.pictures
      end

      describe "when user not logged in" do
        it "should redirect to sign_in" do
          get :index, muscle_id: @pictureable.id
          expect(response).to redirect_to("/users/sign_in")
        end
      end

      describe "when user logged in, but not admin" do
        login_user(admin: false)

        it "should raise CanCan::AccessDenied" do
          expect { get :index, muscle_id: @pictureable.id }.to raise_error(CanCan::AccessDenied)
        end
      end

      describe "when user logged in as admin" do
        login_user(admin: true)

        it "renders the index template" do
          get :index, muscle_id: @pictureable.id
          expect(response).to render_template("index")
        end

        it "assigns @pictures" do
          get :index, muscle_id: @pictureable.id
          expect(assigns(:pictures)).to eq(@pictures)
        end
      end
    end

    describe "should raise UnknownFormat for" do
      login_user(admin: true)

      before (:each) do
        @pictureable = create(:muscle, pictures: create_list(:picture, 5))
      end

      it "POST create" do
        params = { muscle_id: @pictureable.id, picture: attributes_for(:picture) }
        expect { post :create, params }.to raise_error(ActionController::UnknownFormat)
      end

      it "PUT update" do
        params = { id: @pictureable.pictures.first.id, picture: attributes_for(:picture) }
        expect { put :update, params }.to raise_error(ActionController::UnknownFormat)
      end

      it "DELETE destroy" do
        params = { id: @pictureable.pictures.first.id }
        expect { delete :destroy, params }.to raise_error(ActionController::UnknownFormat)
      end

    end
  end

  describe "JSON API when user is admin for" do
    login_user(admin: true)

    before (:each) do
      @pictureable = create(:muscle, pictures: [create(:picture)])
    end

    it 'GET index' do
      @pictureable.pictures = create_list(:picture, 10)
      @pictureable.save!
      get :index, muscle_id: @pictureable.id, format: :json
      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json.length).to eq(10)
    end

    it 'POST create' do
      params = { muscle_id: @pictureable.id, format: 'json', picture: attributes_for(:picture) }
      expect{ post :create, params }.to change { Picture.count }.by 1
      expect(response).to be_success
    end

    it 'PUT update' do
      picture = @pictureable.pictures.first
      params = { id: picture.id, format: 'json', picture: { name: 'new_name' } }
      put :update, params
      picture.reload
      expect(response).to be_success
      expect(picture.name).to eq 'new_name'
    end

    it 'DELETE destroy' do
      picture = @pictureable.pictures.first
      params = { id: picture.id, format: 'json' }
      expect{ delete :destroy, params }.to change { Picture.count }.by -1
      expect(response).to be_success
    end

  end

  describe "JSON API when user is not admin should be denied for" do
    login_user(admin: false)

    before (:each) do
      @pictureable = create(:muscle, pictures: [create(:picture)])
    end

    it 'GET index' do
      expect { get :index, muscle_id: @pictureable.id, format: :json }.to raise_error(CanCan::AccessDenied)
    end

    it 'POST create' do
      params = { muscle_id: @pictureable.id, format: 'json', picture: attributes_for(:picture) }
      expect { post :create, params }.to raise_error(CanCan::AccessDenied)
    end

    it 'PUT update' do
      picture = @pictureable.pictures.first
      params = { id: picture.id, format: 'json', picture: { name: 'new_name' } }
      expect { put :update, params }.to raise_error(CanCan::AccessDenied)
    end

    it 'DELETE destroy' do
      picture = @pictureable.pictures.first
      params = { id: picture.id, format: 'json' }
      expect { delete :destroy, params }.to raise_error(CanCan::AccessDenied)
    end
  end

end
