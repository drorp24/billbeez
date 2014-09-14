class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter.weekly.subject
  #
  def weekly(newsletter)
#    attachments.inline['yes.png'] = File.read("#{Rails.root}/public/images/yes.png")
    @newsletter = newsletter
    @version =    @newsletter.version
    @email =      @newsletter.customer.email

    mail to: @email, subject: Billbeez::Application.config.newsletter_subject
  end
end
