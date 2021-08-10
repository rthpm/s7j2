class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]

  def index
    @all_events = Event.all
  end

  def secret; end
end
