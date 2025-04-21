class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :store_per_page

  private
  def store_per_page
    if params[:per_page].present?
      session[:per_page] = params[:per_page].to_i
    end
  end

  def per_page
    session[:per_page] || 5
  end
end
