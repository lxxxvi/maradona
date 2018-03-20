class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['tippkick.club@gmail.com']
  end
end

if Rails.env.development? || Rails.env.staging?
  ActionMailer::Base.register_interceptor(SandboxEmailInterceptor)
end
