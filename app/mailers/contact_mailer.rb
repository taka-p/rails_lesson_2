class ContactMailer < ApplicationMailer
	default from: "hoge@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.sent.subject
  #
  def sent(contact)
    @contact = contact

    mail(to: @contact.email, subject: "Thank you for your contact!")
  end
end
