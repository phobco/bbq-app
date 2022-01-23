class EventEmailNotificationJob < ApplicationJob
  queue_as :default

  def perform(object)
    event = object.event
    mailer_method = object.class.to_s.downcase

    all_emails = 
      (event.subscriptions.map(&:user_email) + [event.user.email]).uniq - [object&.user&.email]
    
    all_emails.each { |mail| EventMailer.method(mailer_method).call(event, object, mail).deliver_later }
  end
end
