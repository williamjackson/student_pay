class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include PaySheetsHelper
  include ApplicationHelper
end
