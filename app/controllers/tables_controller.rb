class TablesController < ApplicationController
  def index
  end

  def new
    @table = Table.new
  end

  def create
    t = Table.create(table_params)

    if t.valid?
      flash[:success] = "Table successfully added."
    else
      flash[:alert] = t.errors.full_messages.join('. ')
    end

    redirect_to new_table_path
  end

  def destroy
  end

  def map
    @map_url = Table.find(params[:table_id]).map_url
  end

  private
  def table_params
    params.require(:table).permit(:name, :map_url)
  end
end
