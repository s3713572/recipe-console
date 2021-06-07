class RecipesController < ApplicationController
  include S3Uploader
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :upload_cover, only: %i[create update]

  # GET /receipts or /receipts.json
  def index
    @recipes = Recipe.all
  end

  # GET /receipts/1 or /receipts/1.json
  def show; end

  # GET /receipts/new
  def new
    @recipe = Recipe.new
    @count = params[:count].to_i || 1
    @recipe_foods = @count.times.map { @recipe.recipe_foods.new }
  end

  def enter_form; end

  # GET /receipts/1/edit
  def edit
    @recipe_foods = @recipe.recipe_foods
  end

  # POST /receipts or /receipts.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @count = recipe_params[:recipe_foods_attributes].keys.last.to_i + 1

        format.html { render 'new', count: @count, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe/1 or /receipts/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe/1 or /receipts/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :content, :cover_url,
                                   recipe_foods_attributes: %i[id food_id unit count])
  end

  def upload_cover
    return unless params[:recipe][:image_file]

    @image_file = params[:recipe][:image_file].read.force_encoding('UTF-8')
    content_type = params[:recipe][:image_file].content_type
    if @image_file.size > 2.megabytes || content_type.exclude?('image')
      render 'edit'
    else
      # 创建Tempfile上传到s3目录'shipping_service_images'并删除Tempfile
      begin
        image_name = "file_#{recipe_params[:id]}"
        file = Tempfile.new(image_name)
        file.write @image_file
        file.close
        url = upload_image(file.path)
        params[:recipe][:cover_url] = url
        puts url
      ensure
        file.delete
      end
    end
  end
end
