# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :herd_user
  load_and_authorize_resource
end
