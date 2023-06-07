class RecipesController < ApplicationController
  def index
    @user = User.includes(:recipes).find(current_user.id)
    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @foods = Food.all
    @recipes_foods = @recipe.recipe_foods
  end

  def new
    new_recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: new_recipe } }
    end
  end

  def create
    @new_recipe = Recipe.new(params.require(:recipe).permit(:name, :public, :cooking_time, :preparation_time,
                                                            :description))
    @new_recipe.user = current_user
    authorize! :create, @new_recipe
    respond_to do |format|
      if @new_recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize! :update, @recipe
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    authorize! :destroy, recipe
    recipe.destroy
    flash[:notice] = 'Recipe has been deleted!'
    redirect_to recipes_path
  end

  def public_recipes
    @recipes = Recipe.includes(recipe_foods: :food).where(public: true).order('created_at DESC')
  end

  def general_shopping_list
    @user = User.includes(:recipes, :foods).find(current_user.id)
    @recipes = @user.recipes
    @foods = @user.foods
    @shopping_list = RecipeFood.includes(:food).where(recipe_id: @recipes)
    @required_food = {}
    @shopping_list.each do |recipe_food|
      food = { 'food_name' => '', 'quantity' => 0, 'value' => 0 }
      if @required_food.include?(recipe_food.food.name)
        @required_food[recipe_food.food.name]['quantity'] -= recipe_food.quantity
        puts @required_food[recipe_food.food.name]['quantity']
      else
        food['food_name'] = recipe_food.food.name
        food['quantity'] = recipe_food.food.quantity - recipe_food.quantity
        food['value'] = recipe_food.food.price
        puts recipe_food.food.name
        @required_food[recipe_food.food.name] = food
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end