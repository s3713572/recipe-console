class FoodsController < ApplicationController
  include S3Uploader

  before_action :set_food, only: %i[show edit update destroy]
  before_action :upload_cover, only: %i[create update]

  # GET /foods or /foods.json
  def index
    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show; end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :food_type, :img_url)
  end

  def upload_cover
    return unless params[:food][:image_file]

    @image_file = params[:food][:image_file].read.force_encoding('UTF-8')
    content_type = params[:food][:image_file].content_type
    if @image_file.size > 2.megabytes || content_type.exclude?('image')
      render 'edit'
    else
      # 创建Tempfile上传到s3目录'shipping_service_images'并删除Tempfile
      begin
        image_name = "file_#{food_params[:id]}"
        file = Tempfile.new(image_name)
        file.write @image_file
        file.close
        url = upload_image(file.path)
        params[:food][:img_url] = url
        puts url
      ensure
        file.delete
      end
    end
  end
end
