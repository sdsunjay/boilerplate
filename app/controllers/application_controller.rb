class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def set_user
    return @user if defined? @user

    @user = current_user
  end

  # def authenticate_user!
  #  redirect_to new_user_session_path unless user_signed_in?
  # end

  def user_signed_in?
    # converts current_user to a boolean by negating the negation
    !!current_user
  end

  def require_admin
    unless current_user.admin? || current_user.super_admin?

      flash[:alert] = 'Access denied'
      redirect_back fallback_location: user_path(current_user.id), allow_other_host: false
    end
  end

  def set_user
    return @user if defined? @user

    @user = current_user
  end

  def set_user_products
    return @user_products if defined? @user_products

    if user_signed_in?
      @user_products = @user.products
    else
      redirect_to new_user_session_path unless user_signed_in?
    end
  end

  def set_per_page
    @per_page = params[:per_page] || 120
    @per_page = 120 if @per_page.to_i > 150
  end
end
