# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simple_blog_session',
  :secret      => '64b0bf08777bb2a4947f0b1b1b7b602a21cc234d5a2dcce7e0601d40ad92f6a3eb0921aa86d42672096eacff6cda538856cba1444cd49618418c9d6ccc70c4df'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
