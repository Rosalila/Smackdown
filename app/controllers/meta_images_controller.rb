class MetaImagesController < ApplicationController
  before_action :set_meta_image, only: [:show, :edit, :update, :destroy]

  # GET /meta_images
  # GET /meta_images.json
  def index
    if !userIsAdmin
      redirect_to "/"
    end
    @meta_images = MetaImage.all
  end

  # GET /meta_images/1
  # GET /meta_images/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
    end
  end

  # GET /meta_images/new
  def new
    if !userIsAdmin
      redirect_to "/"
    end
    @meta_image = MetaImage.new
  end

  # GET /meta_images/1/edit
  def edit
  end

  # POST /meta_images
  # POST /meta_images.json
  def create
    if !userIsAdmin
      redirect_to "/"
    end
    @meta_image = MetaImage.new(meta_image_params)

    respond_to do |format|
      if @meta_image.save
        format.html { redirect_to @meta_image, notice: 'Meta image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meta_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @meta_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meta_images/1
  # PATCH/PUT /meta_images/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
    end
    respond_to do |format|
      if @meta_image.update(meta_image_params)
        format.html { redirect_to @meta_image, notice: 'Meta image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meta_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_images/1
  # DELETE /meta_images/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
    end
    @meta_image.destroy
    respond_to do |format|
      format.html { redirect_to meta_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meta_image
      @meta_image = MetaImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meta_image_params
      params.require(:meta_image).permit(:path)
    end
end
