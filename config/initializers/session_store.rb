# Be sure to restart your server when you modify this file.

# Logan::Application.config.session_store :cookie_store, key: '_cutgroup_session', secure: (Rails.env.production? || Rails.env.staging?)
Rails.application.config.session_store :cookie_store, key: "_rails_session_#{Rails.env}", domain: :all
