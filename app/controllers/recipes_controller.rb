class FoodsController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipes_params)

    if @recipe.valid?
      @recipe.save
      flash[:notice] = 'successfully added'
      redirect_to recipes_path
    else
      flash[:alert] = 'not added'
      @error = @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:notice] = 'Recipe has been deleted!'
    redirect_to recipes_path
  end

  private

  def recipes_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description).merge(user: current_user)
  end
end
