class GuestsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
  end

  def search
    @results = Guest.where("last_name ilike ?", "#{params["last_name"].strip}%")
  end

  def welcome
  end
end
