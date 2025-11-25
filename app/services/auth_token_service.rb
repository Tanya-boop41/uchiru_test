require 'digest'

class AuthTokenService
  def self.generate(student_id)
    salt = Rails.application.credentials.auth_salt || ENV['AUTH_SALT'] || 'default_dev_salt'
    Digest::SHA256.hexdigest("#{student_id}#{salt}")
  end
end
