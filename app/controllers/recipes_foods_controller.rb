class RecipesFoodsController < ApplicationController
    def new
      @recipe_food = RecipeFood.new
    end
  
    def create
      @new_recipe_food = RecipeFood.new(recipe_params)
      @new_recipe_food.recipe_id = params[:recipe_id]
  
      respond_to do |format|
        if @new_recipe_food.save
          format.html { redirect_to "/recipes/#{params[:recipe_id]}", notice: 'Recipe_food was successfully created.' }
        else
          format.html { render :new, status: :unprocessable_entity }
          @error = @new_recipe_food.errors.full_messages
          puts @error
        end
      end
    end
  
    def edit
      @recipe_food = RecipeFood.find(params[:id])
    end
  
    def update
      @recipe_food = RecipeFood.find(params[:id])
  
      if @recipe_food.update(recipe_params_update)
        redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Recipe_food was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      recipe_food = RecipeFood.find(params[:id])
  
      recipe_food.destroy
      flash[:notice] = 'Recipe has been deleted!'
      redirect_to "/recipes/#{params[:recipe_id]}"
    end
  
    private
  
    def recipe_params
      params.require(:recipe_food).permit(:food_id, :quantity)
    end
  
    def recipe_params_update
      params.require(:recipe_food).permit(:quantity)
    end
  end