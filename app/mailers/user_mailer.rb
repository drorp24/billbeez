class UserMailer < ActionMailer::Base
  default from: "support@billbeez.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter.weekly.subject
  #
  def weekly(newsletter)
#    attachments.inline['yes.png'] = File.read("#{Rails.root}/public/images/yes.png")
    @newsletter = newsletter
    @version =    @newsletter.version
    @campaign =   @version.campaign
    @email =      @newsletter.customer.email

    mail from: @campaign.from_email, to: @email, subject: @campaign.subject 
  end
end
