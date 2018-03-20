class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['tippkick.club@gmail.com']
  end
end

unless Rails.env.production?
  ActionMailer::Base.register_interceptor(SandboxEmailInterceptor)
end
