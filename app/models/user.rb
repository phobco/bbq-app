class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 vkontakte github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :identities, dependent: :destroy

  validates :name, presence: true, length: { maximum: 14 }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  class << self
    def find_for_oauth(provider, access_token)
      find_or_create_user(access_token, provider)
    end

    private

    def find_or_create_user(access_token, provider)
      email = access_token.info.email
      return if email.blank?

      name =
        case provider
        when :github   then access_token.info.nickname
        else access_token.info.first_name
        end

      avatar =
        case provider
        when :vkontakte then access_token.extra.raw_info.photo_400_orig
        else access_token.info.image
        end

      user = find_by(email: email) || create_oauth_user(access_token, name, avatar)

      provider = access_token.provider
      uid = access_token.uid

      Identity.find_or_create_by(provider: provider, uid: uid, user: user).user
    end

    def create_oauth_user(access_token, name, avatar)
      create(
        name: name.first(14),
        email: access_token.info.email,
        password: Devise.friendly_token.first(16),
        remote_avatar_url: avatar
      )
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end
end
