class CustomerMailer < ActionMailer::Base
  default from: Rails.application.secrets.mail_sender
 
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample.sample_mail.subject
  #
  def payment_confirmation(payment)
    @payment = payment
    mail to: payment.user.email,
         bcc: Rails.application.secrets.mail_sender
  end
end
