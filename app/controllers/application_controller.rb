class ApplicationController < ActionController::API
  private

  def require_auth_for_user!(user_id)
    auth_header = request.headers['Authorization']
    token = auth_header&.split&.last
    expected = AuthTokenService.generate(user_id.to_s)
    head :unauthorized unless ActiveSupport::SecurityUtils.secure_compare((token || ''), (expected || ''))
  rescue
    head :unauthorized
  end
end
