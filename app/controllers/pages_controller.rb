class PagesController < ApplicationController
  def home
    @fighters = Fighter.all
  end
end
