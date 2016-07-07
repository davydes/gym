require 'rails_helper'

RSpec.describe References::MusclesController, type: :controller do
  before (:context) do
    @muscle = create(:muscle)
  end

  describe "GET index" do
    it "assigns @muscles" do
      get :index
      expect(assigns(:muscles)).to eq([@muscle])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @muscle" do
      get :show, id: @muscle.id
      expect(assigns(:muscle)).to eq(@muscle)
    end

    it "renders the show template" do
      get :show, id: @muscle.id
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
        attributes_for(:muscle)
      end

      before(:each) do
        post :create, muscle: attr
        @muscle = References::Muscle.last
      end

      it { expect(response).to redirect_to(@muscle) }
      it { expect(@muscle.name).to eql attr[:name] }
      it { expect(@muscle.alias).to eql attr[:alias] }
      it { expect(@muscle.shape).to eql attr[:shape] }
    end
  end

  describe "GET edit" do
    describe "when user logged in" do
      login(admin: true)

      it "assigns @muscle" do
        get :edit, id: @muscle.id
        expect(assigns(:muscle)).to eq(@muscle)
      end

      it "renders the edit template" do
        get :edit, id: @muscle.id
        expect(response).to render_template("edit")
      end
    end

    describe "when user logged out" do
      it 'should redirect to sign_in' do
        get :edit, id: @muscle.id
        expect(subject).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "PUT update" do
    describe "when user logged in" do
      login(admin: true)

      let(:attr) do
        { :name => 'new name', :alias => 'new_alias', :shape => 'short' }
      end

      before(:example) do
        @muscle = create(:muscle)
      end

      before(:each) do
        put :update, :id => @muscle.id, :muscle => attr
        @muscle.reload
      end

      it { expect(response).to redirect_to(@muscle) }
      it { expect(@muscle.name).to eql attr[:name] }
      it { expect(@muscle.alias).to eql attr[:alias] }
      it { expect(@muscle.shape).to eql attr[:shape] }
    end
  end

  describe "DELETE destroy" do
    describe "when user logged in" do
      login(admin: true)

      before(:example) do
        @muscle = create(:muscle)
      end

      it "should destroy muscle" do
        expect{delete :destroy, :id => @muscle.id}.to change{References::Muscle.count}.by(-1)
      end

      it "should redirect to muscles_path" do
        delete :destroy, :id => @muscle.id
        expect(response).to redirect_to(references_muscles_path)
      end
    end
  end

end
