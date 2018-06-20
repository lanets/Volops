class PagesController < ApplicationController
  skip_authorization_check only: [:index]

  def index; end

end