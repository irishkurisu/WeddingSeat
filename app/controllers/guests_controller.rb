class GuestsController < ApplicationController
  def new
    @guest = Guest.new
  end

  def create
    g = Guest.create(guest_params)
    if g.valid?
      flash[:success] = "Guest successfully added."
    else
      flash[:alert] = g.errors.full_messages.join('. ')
    end

    redirect_to new_guest_path
  end

  def destroy
  end

  def search
    @results = Guest.where("last_name ilike ?", "#{params["last_name"].strip}%")
  end

  def welcome
  end

  private
  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :table_id)
  end
end
