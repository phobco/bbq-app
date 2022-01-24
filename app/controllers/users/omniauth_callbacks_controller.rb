class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, __method__)
  end

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, __method__)
  end

  def google_oauth2
    @user = User.find_for_google_oauth2_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, __method__)
  end
  
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    authenticate_user(@user, __method__)
  end

  private

  def authenticate_user(user, provider)
    if user.eql?(:email_missing)
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: provider, reason: 'отсутствует email')

      redirect_to new_user_session_path
    elsif user.persisted?
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: provider)

      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: provider, reason: 'ошибка аутентификации')
      
      redirect_to root_path
    end
  end
end
