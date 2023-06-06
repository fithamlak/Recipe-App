class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(foods_params)

    if @food.valid?
      @food.save
      flash[:notice] = 'successfully added'
      redirect_to foods_path
    else
      flash[:alert] = 'not added'
      @error = @food.errors.full_messages
      render :new
    end
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    flash[:notice] = 'Food has been deleted!'
    redirect_to foods_path
  end

  private

  def foods_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end
