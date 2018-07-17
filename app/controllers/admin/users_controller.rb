module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all
    end


  end
end