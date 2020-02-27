class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  # GET /tables
  # GET /tables.json
  def index
    @tables = Table.all
    if Table.where("name like ?", "% #{Date.today} %").first
      @tables = Table.all
    else
      @table = Table.new(name:Date.today, user_id: current_user.id)
      @table.save

    end


  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    s = @table.name.to_s
    arr = s.split("-")
    t1 = DateTime.new(arr[0].to_i,arr[1].to_i,arr[2].to_i,0,0)
    t2 = DateTime.new(arr[0].to_i,arr[1].to_i,arr[2].to_i,23,59)

    if current_user.admin?
      all = Meal.all
      @meals = Meal.admin_time_filter(all,t1,t2)
    else
      all = current_user.meals
      @meals = Meal.time_filter(all,t1,t2)
      @calories = 0.0
      @meals.each do |x|
          @calories += x.calories
        end
      @calories
    end

  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
    @table.user = current_user
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)
    @table.user = current_user

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table.destroy
    respond_to do |format|
      format.html { redirect_to tables_url, notice: 'Table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def table_params
      params.require(:table).permit(:name, :user_id, :norm)
    end
end
