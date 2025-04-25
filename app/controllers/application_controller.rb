class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Callback methods registered via before_action run before a controller action.
  # They may halt the request cycle.
  # As "before_action", we have "after_action" and "around_action" (runs both before and after).
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # This hooks adds a default URL parameter globally. This means it will be added to all URLs.
  # Example: /transactions -> en/transactions, jp/transactions.
  def default_url_options
    { locale: I18n.locale }
  end
end
