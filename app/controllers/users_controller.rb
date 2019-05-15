class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]
  before_action :require_admin, only: %i[destroy index]

  # GET /users
  # GET /users.json
  def index
    @page_title = 'Accounts'
    @pagy, @users = pagy(User.all.order(created_at: :desc), items: 100)
  end

  # GET /users/:id.:format
  def show
    @page_title = @user.name

    @pagy_products, @products = pagy(@user.products.order(created_at: :desc), page_param: :page_products, params: { active_tab: 'products-tab' })
    @number_of_products = if @products.blank?
                            0
                          else
                            @user.products.count
                          end
    # @pagy_orders, @orders = pagy(Order.includes(:product).where(product_id: Product.where(user_id: @user)).order(created_at: :desc), page_param: :page_orders, params: { active_tab: 'orders-tab' })
    # if @orders.blank?
    #  @number_of_orders = 0
    #  @total_sales = 0
    #  @avg_total = 0
    #else
      # TODO: Fix this warning
    #  @number_of_orders = Order.where(product_id: Product.where(user_id: @user)).count
    #  @total_sales = Order.where(product_id: Product.where(user_id: @user)).sum(:total_cents)
    #  @avg_sales = Order.where(product_id: Product.where(user_id: @user)).average(:total_cents).round(2)
    # end
    # @pagy_inventories, @inventories = pagy(Inventory.includes(:product).where(product_id: Product.where(user_id: @user)).order(created_at: :desc), page_param: :page_inventories, params: { active_tab: 'inventories-tab' })
    # @inventory_count = Inventory.where(product_id: Product.where(user_id: @user)).count
  end

  # GET /users/:id/edit
  def edit
    @page_title = 'Edit Account'
  end

  # PATCH/PUT /users/:id.:format
  def update
    @page_title = 'Edit Account'
    # authorize! :update, @user_edit
    respond_to do |format|
      if @user.update(user_params)
        # Sign in the user bypassing validation
        # bypass_sign_in(@user_edit)
        format.html { redirect_to user_path, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    # extend with your own params
    accessible = %i[name email]
    params.require(:user).permit(accessible)
  end
end
