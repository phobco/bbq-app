# "BBQ" — "Шашлыки"

###### Ruby: `2.7.4` Rails: `6.1.4` Language `Russian`

### About

An application where you can create events and meetings, subscribe to them, add photos, comments, mark a place on the map and receive email notifications.

Quick registration via: `Google`, `Github`, `VKontakte`

The location of the event is displayed in `Yandex.Maps`

Images and photos are stored on [`Amazon S3`](https://aws.amazon.com/s3/) bucket.

### Gems used

- [`devise`](https://github.com/heartcombo/devise) to work with users
- [`rails-i18n`](https://github.com/svenfuchs/rails-i18n) to internationalization
- [`pundit`](https://github.com/varvet/pundit) to authentication
- [`carrierwave`](https://github.com/carrierwaveuploader/carrierwave) to upload images
- [`rmagick`](https://github.com/rmagick/rmagick)
- [`fog-aws`](https://github.com/fog/fog-aws)
- [`mailjet`](https://github.com/mailjet/mailjet-gem) for email notifications
- [`rspec-rails`](https://github.com/rspec/rspec-rails) for tests
- [`factory_bot_rails`](https://github.com/thoughtbot/factory_bot_rails)
- [`resque`](https://github.com/resque/resque) for background jobs
- [`capistrano`](https://github.com/capistrano/capistrano) for deployment
- [`omniauth-rails_csrf_protection`](https://github.com/cookpad/omniauth-rails_csrf_protection) for OAuth authentication
  - [`omniauth-google-oauth2`](https://github.com/zquestz/omniauth-google-oauth2)
  - [`omniauth-github`](https://github.com/omniauth/omniauth-github)
  - [`omniauth-vkontakte`](https://github.com/mamantoha/omniauth-vkontakte)
- ...

### Installation

1. Clone repo
```
$ git clone git@github.com:phobco/bbq.git
$ cd bbq
```

2. Set up `config/database.yml.example` for your database and rename it
```
$ mv config/database.yml.example config/database.yml
```

3. Install gems
```
$ bundle
```

4. Create database and run migrations
```
$ rails db:create
$ rails db:migrate
```

5. Generate `master.key` and credentials file
```
$ EDITOR=nano rails credentials:edit
```

Example of `credentials.yml.enc` (**Optional for services working**)
```yml
# AWS and Mailjet for production mode only
aws:
  s3_access_key_id: <value>
  s3_secret_access_key: <value>
  s3_region: <value>
  s3_bucket_name: <value>
mail:
  default_mail: <value>
  mailjet_api_key: <value>
  mailjet_secret_key: <value>
maps:
  api_key: <value>
oauth:
  vkontakte_app_id: <value>
  vkontakte_secret_key: <value>
  github_client_id: <value>
  github_secret_key: <value>
  google_oauth2_app_id: <value>
  google_oauth2_secret_key: <value>
```

`:aws` — [`Amazon S3`](https://aws.amazon.com/s3/)

`:mail` — [`Mailjet`](https://www.mailjet.com/)

`:maps` — [`Yandex.Maps API`](https://yandex.ru/dev/maps)

`:oauth` — [`OAuth VK`](https://dev.vk.com/) [`OAuth Github`](https://developer.github.com/) [`OAuth Google`](https://developers.google.com/identity/protocols/oauth2)

6. Start sever
```
$ rails s
```

Open `localhost:3000` in browser.

### Production link

Deployed on `Heroku`: [`link`](https://bbq-phobco.herokuapp.com/)
