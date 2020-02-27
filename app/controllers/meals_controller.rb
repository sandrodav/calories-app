class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all
  end

  def search
      if (params[:d1].blank? || params[:d2].blank? || params[:t1].blank? ||params[:t2].blank?)
       @result = Meal.all
       @message = "Please input full time "
      else
        d1 = params[:d1].split("-")
        d2 =params[:d2].split("-")
        t1 =params[:t1].split(":")
        t2 =params[:t2].split(":")
        time1 = DateTime.new(d1[0].to_i, d1[1].to_i,d1[2].to_i, t1[0].to_i, t1[1].to_i)
        time2 = DateTime.new(d2[0].to_i, d2[1].to_i, d2[2].to_i, t2[0].to_i, t2[1].to_i)
        all = Meal.all
        @result = all.search(all,time1,time2)
      end

  end

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
    @meal.user = current_user
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:name, :calories, :date, :user_id)
    end
end
