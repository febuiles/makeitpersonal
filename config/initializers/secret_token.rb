# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Makeitpersonal::Application.config.secret_token = ENV['secret'] || 'beb7bad007016aed01067e4cfae2a0fa5ea31a538fe3904d528a69a17bc0eccff05f16d35516f3cd815f274f9bd74743806aa92e700a4c740b2c01a6e6746b2f'
