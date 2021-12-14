class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :email_exists, unless: -> { user.present? }
  validate :subscriber, if: -> { user.present? }

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  def email_exists
    errors.add(:user_email, :already_exists) if User.find_by(email: user_email)
  end

  def subscriber
    errors.add(:user_id, :subscription_error) if event.user == user
  end
end
