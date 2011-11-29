class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      @jobs = current_user.jobs
      @pay_period = PayPeriod.current
    end
  end

  def about
    @title = 'About'
  end
  
  def help
    @title = 'Help'
  end
end
