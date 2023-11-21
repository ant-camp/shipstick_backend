class ProductsController < ApplicationController
  before_action :set_product, only: [:update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end
  
  # GET /products/find_by_dimensions
  def show
    length = params[:length].to_i
    width = params[:width].to_i
    height = params[:height].to_i
    weight = params[:weight].to_i

    @product = select_product(length, width, height, weight)

    if @product
      render json: { name: @product.name }
    else
      render json: { error: 'No suitable product found' }, status: :not_found
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    head :no_content
  end

  private
    def select_product(length, width, height, weight)
      @product = Product.find_best_match(length, width, height, weight)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end
end