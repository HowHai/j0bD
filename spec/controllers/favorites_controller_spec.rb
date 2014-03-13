require 'spec_helper'

describe FavoritesController do

  describe "GET 'index'" do
    it "returns http success" do
      Favorite.should_receive(:all).and_return("An array of Favorites")
      get 'index'
      expect(assigns(:favorites)).to eq("An array of Favorites")
      response.should be_success
    end
  end

end
