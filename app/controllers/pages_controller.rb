class PagesController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :only => [:index]

  def index
  end

  def dashboard
  end
end