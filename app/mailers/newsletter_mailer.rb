class NewsletterMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter.weekly.subject
  #
  def weekly(email)
#    attachments.inline['bezeq.png'] = File.read('images/bezeq.png')
    @greeting = "Hi"

    mail to: email, subject:"Test subject"
  end
end
