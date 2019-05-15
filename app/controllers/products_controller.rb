class ProductsController < ApplicationController
  before_action :set_user, only: %i[new create show edit update destroy index]
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:name].present?
      @pagy, @products = pagy(Product.search(params[:name], @user.id), items: 100)
    else
      @pagy, @products = pagy(Product.search(nil, @user.id), items: 100)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @page_title = @product.name
    @name = @product.user.name
    # @pagy_orders, @orders = pagy(@product.orders, items: 100)
    # @pagy_inventories, @inventories = pagy(@product.inventories, items: 100)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = @user.id

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /products
  # POST /products.json
  def search; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = @user.products.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    accessible = %i[name description style brand url product_type]
    params.require(:product).permit(accessible)
  end
end
