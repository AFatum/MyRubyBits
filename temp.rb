require 'active_support/all'
new_options = {user: 'codeschool', lang: 'fr', password: 'dunno'}

new_options.except!(:password)

new_options.assert_valid_keys(:user, :lang)