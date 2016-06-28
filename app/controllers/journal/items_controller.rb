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
    @item.update(item_params)
    @item.save
    respond_with @item
  end

  def create
    @item = current_user.journal.items.new(item_params)
    @item.save
    respond_with @item
  end

  def destroy
    @item = current_user.journal.items.find(params[:id])
    @item.destroy!
    respond_with @item
  end

  private

  def item_params
    res = params.permit(
        :executed_at,
        workout_attributes: [
            :name,
            items_attributes: [
                :exercise_id,
                :pos,
                sets: [:weight, :repeats]
            ]
        ]
    )
    res[:executed_at] = Time.at(res[:executed_at])
    res
  end
end