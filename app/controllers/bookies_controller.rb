class BookiesController < ApplicationController
  def index
    @rows = BookiesService.new(current_user).rows
  end
end
