require 'rails_helper'

RSpec.describe References::BodyPartsController, type: :controller do
  before (:context) do
    @body_part = create(:body_part)
  end

  describe "GET index" do
    it "assigns @body_parts" do
      get :index
      expect(assigns(:body_parts)).to eq([@body_part])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @body_part" do
      get :show, id: @body_part.id
      expect(assigns(:body_part)).to eq(@body_part)
    end

    it "renders the show template" do
      get :show, id: @body_part.id
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    describe "when user logged in" do
      login(admin: true)

      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end

    describe "when user logged out" do
      it 'should redirect to sign_in' do
        get :new
        expect(subject).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "POST create" do
    describe "when user logged in" do
      login(admin: true)

      let(:attr) do
        attributes_for(:body_part)
      end

      before(:each) do
        post :create, body_part: attr
        @body_part = References::BodyPart.last
      end

      it { expect(response).to redirect_to(@body_part) }
      it { expect(@body_part.name).to eql attr[:name] }
      it { expect(@body_part.alias).to eql attr[:alias] }
    end
  end

  describe "GET edit" do
    describe "when user logged in" do
      login(admin: true)

      it "assigns @body_part" do
        get :edit, id: @body_part.id
        expect(assigns(:body_part)).to eq(@body_part)
      end

      it "renders the edit template" do
        get :edit, id: @body_part.id
        expect(response).to render_template("edit")
      end
    end

    describe "when user logged out" do
      it 'should redirect to sign_in' do
        get :edit, id: @body_part.id
        expect(subject).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "PUT update" do
    describe "when user logged in" do
      login(admin: true)

      let(:attr) do
        { :name => 'new name', :alias => 'new_alias' }
      end

      before(:example) do
        @body_part = create(:body_part)
      end

      before(:each) do
        put :update, :id => @body_part.id, :body_part => attr
        @body_part.reload
      end

      it { expect(response).to redirect_to(@body_part) }
      it { expect(@body_part.name).to eql attr[:name] }
      it { expect(@body_part.alias).to eql attr[:alias] }
    end
  end

  describe "DELETE destroy" do
    describe "when user logged in" do
      login(admin: true)

      before(:example) do
        @body_part = create(:body_part)
      end

      it "should destroy body_part" do
        expect{delete :destroy, :id => @body_part.id}.to change{References::BodyPart.count}.by(-1)
      end

      it "should redirect to body_parts_path" do
        delete :destroy, :id => @body_part.id
        expect(response).to redirect_to(references_body_parts_path)
      end
    end
  end

  context 'JSON' do
    let (:body_parts) { create_list(:body_part, 5) }
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    describe 'GET #index' do
      describe 'responds body_parts as json with' do
        it 'right count' do
          count = References::BodyPart.count+body_parts.count
          get :index
          json = JSON.parse(response.body)
          expect(json.length).to eq(count)
        end

        it 'extended format' do
          get :index
          json = JSON.parse(response.body)
          expect(json.first.keys).to eq(%w(id name alias description muscles exercises))
        end

        it 'short format' do
          get :index, {short:1}
          json = JSON.parse(response.body)
          expect(json.first.keys).to eq(%w(id name alias))
        end
      end
    end
  end
end
