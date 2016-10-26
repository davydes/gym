require 'rails_helper'

RSpec.describe References::ExercisesController, type: :controller do
  before (:context) do
    @exercise = create(:exercise)
  end

  describe "GET index" do
    it "assigns @exercises" do
      get :index
      expect(assigns(:exercises)).to eq([@exercise])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @exercise" do
      get :show, id: @exercise.id
      expect(assigns(:exercise)).to eq(@exercise)
    end

    it "renders the show template" do
      get :show, id: @exercise.id
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
        attributes_for(:exercise)
      end

      before(:each) do
        post :create, exercise: attr
        @exercise = References::Exercise.last
      end

      it { expect(response).to redirect_to(@exercise) }
      it { expect(@exercise.name).to eql attr[:name] }
      it { expect(@exercise.alias).to eql attr[:alias] }
    end
  end

  describe "GET edit" do
    describe "when user logged in" do
      login(admin: true)

      it "assigns @exercise" do
        get :edit, id: @exercise.id
        expect(assigns(:exercise)).to eq(@exercise)
      end

      it "renders the edit template" do
        get :edit, id: @exercise.id
        expect(response).to render_template("edit")
      end
    end

    describe "when user logged out" do
      it 'should redirect to sign_in' do
        get :edit, id: @exercise.id
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
        @exercise = create(:exercise)
      end

      before(:each) do
        put :update, :id => @exercise.id, :exercise => attr
        @exercise.reload
      end

      it { expect(response).to redirect_to(@exercise) }
      it { expect(@exercise.name).to eql attr[:name] }
      it { expect(@exercise.alias).to eql attr[:alias] }
    end
  end

  describe "DELETE destroy" do
    describe "when user logged in" do
      login(admin: true)

      before(:example) do
        @exercise = create(:exercise)
      end

      it "should destroy exercise" do
        expect{delete :destroy, :id => @exercise.id}.to change{References::Exercise.count}.by(-1)
      end

      it "should redirect to exercises_path" do
        delete :destroy, :id => @exercise.id
        expect(response).to redirect_to(references_exercises_path)
      end
    end
  end

  context 'JSON' do
    let (:exercises) { create_list(:exercise, 5) }
    before :each do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    describe 'GET #index' do
      describe 'responds exercises as json with' do
        it 'right count' do
          count = References::Exercise.count+exercises.count
          get :index
          json = JSON.parse(response.body)
          expect(json.length).to eq(count)
        end

        it 'extended format' do
          get :index
          json = JSON.parse(response.body)
          expect(json.first.keys).to eq(%w(id name alias description equipments muscles body_parts))
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
