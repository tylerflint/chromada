# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_chromada_session',
  :secret      => '87840b0490f7b5429a2954d87114a14450e08225be8351932af7b105206055c303f781a28b1b3b06a00a85b102c14e59a2a80b3bc9c1ed41e4fb1e92c641e587'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
