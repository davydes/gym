class Journal::ItemsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, only: [:index]
  respond_to :json

  def index
    @items = current_user.journal.items.eager_load(workout: [items: [:exercise]])
    respond_with @items
  end

  def show
    @item = current_user.journal.items.eager_load(workout: [items: [:exercise]]).find(params[:id])
    respond_with @item
  end

  def update
    @item = current_user.journal.items.eager_load(workout: [items: [:exercise]]).find(params[:id])
    @item.workout.name = params[:workout][:name]
    @item.workout.save()
    @item.save()
    respond_with @item
  end

  def create
    @item = current_user.journal.items.create(
        executed_at: Time.at(params[:executed_at]),
        workout: Workout.new(name: params[:workout][:name])
    )
    respond_with @item
  end

end