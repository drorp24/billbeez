# encoding: UTF-8
class Newsletter < ActiveRecord::Base
  belongs_to    :version
  belongs_to    :customer
  has_one       :campaign, through: :version
  has_one       :locale, through: :customer
  has_many      :dues
  has_many      :notifications
  has_many      :reminders
  has_many      :plans
  
  def dues_sentence_or_none
    if dues.any?
      version.dues_sentence
    else
      "לא נמצאו השבוע חשבוניות לתשלום"
    end  
  end
  def notifications_sentence_or_none
    if notifications.any?
      version.notifications_sentence
    else
      "לא נמצאו השבוע מסמכים חדשים"
    end  
  end
  def reminders_sentence_or_none
    if reminders.any?
      version.reminders_sentence
    else
      "לא קיימות תזכורות והודעות חדשות"
    end  
  end
  def plans_sentence_or_none
    if plans.any?
      version.plans_sentence
    else
      "לא קיימות המלצות חדשות"
    end  
  end
  
  def deliver
    Billbeez::Application.config.use_delayed_job ? UserMailer.delay.weekly(self) : UserMailer.weekly(self).deliver
    customer.update(last_newsletter: Time.now)
    update!(sent_at: Time.now)
  end
  
  def locale_description
    self.locale.description
  end
  
  def locale=
    
  end
end
