class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :store_per_page
  after_action :flash_to_headers
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:alert] = "У вас нет прав на выполнение этого действия."
    redirect_to(request.referrer || root_path)
  end

  def store_per_page
    if params[:per_page].present?
      session[:per_page] = params[:per_page].to_i
    end
  end

  def per_page
    session[:per_page] || 5
  end

  def flash_to_headers
    return unless request.xhr? # только для AJAX-запросов

    response.headers['X-Flash-Notice'] = flash[:notice] if flash[:notice]
    response.headers['X-Flash-Alert'] = flash[:alert] if flash[:alert]
    response.headers['X-Flash-Error'] = flash[:error] if flash[:error]
    flash.discard # очищает flash после отправки
  end

end
