class ApplicationController < ActionController::API
  include ResponseHandler

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
end
