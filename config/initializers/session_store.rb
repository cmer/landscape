# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_landscape_session',
  :secret      => '2cdcddd0c5f739d315e1d80702ae5893e9cfac2aaa1fe5e0d83737c653384c33ff95bd890f347420ee9c32b91050b1e34906b6fa1169a82d0f5df53afe5cbbfd'
}

ActionController::Base.session_store = :active_record_store
