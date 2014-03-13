class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def create
    current_employer.add_favorite(params[:employee])
    @employee = Employee.find(49)
    respond_to do |format|
      format.html { redirect_to current_employer }
      format.js
    end
  end
end
