class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
  end
end
