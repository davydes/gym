class Journal::ItemsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, only: [:index]
  respond_to :json

  def index
    @items = current_user.journal.items
    respond_with @items
  end
end
