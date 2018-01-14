class BookiesController < ApplicationController
  def index
    @rows = BookiesService.new(current_user).rows
  end

  private

  def current_user
    User.first
  end
end
