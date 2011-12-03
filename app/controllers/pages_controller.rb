class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
        redirect_to home_path
    end
  end

  def about
    @title = 'About'
  end
  
  def help
    @title = 'Help'
  end
end
