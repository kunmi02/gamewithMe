class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  
  # Devise authentication
  before_action :authenticate_account!
  
  # Helper method to get current user's profile
  helper_method :current_user_profile
  
  def current_user_profile
    current_account&.user
  end
end
