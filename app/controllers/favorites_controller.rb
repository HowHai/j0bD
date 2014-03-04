class FavoritesController < ApplicationController
  def create
    current_employer.add_favorite(params[:employee])
    redirect_to current_employer
  end
end
