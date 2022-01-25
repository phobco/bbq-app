class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  REASONS = {
    email_missing: I18n.t('devise.omniauth_callbacks.email_missing'),
    authentication_error: I18n.t('devise.omniauth_callbacks.authentication_error')
  }

  PROVIDERS = {
    vkontakte: I18n.t('devise.omniauth_providers.vkontakte'),
    gihub: I18n.t('devise.omniauth_providers.github'),
    google: I18n.t('devise.omniauth_providers.google'),
    facebook: I18n.t('devise.omniauth_providers.facebook')
  }

  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, PROVIDERS[:vkontakte])
  end

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, PROVIDERS[:github])
  end

  def google_oauth2
    @user = User.find_for_google_oauth2_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, PROVIDERS[:google])
  end
  
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, PROVIDERS[:facebook])
  end

  private

  def authenticate_user(user, provider)
    if user.eql?(:email_missing)
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: provider, reason: REASONS[:email_missing])

      redirect_to new_user_session_path
    elsif user.persisted?
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: provider)

      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: provider, reason: REASONS[:authentication_error])
      
      redirect_to root_path
    end
  end
end
