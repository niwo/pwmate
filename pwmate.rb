#!/usr/bin/env ruby

require "mechanize"
require "securerandom"
require "faraday"
require "json"
require "base64"
require 'dotenv/load'


CLOUDSCALE_USER = ENV['CLOUDSCALE_USER']
CLOUDSCALE_PASSWORD = ENV['CLOUDSCALE_PASSWORD']

CRYPTOPUS_USER = ENV['CRYPTOPUS_USER']
CRYPTOPUS_TOKEN = ENV['CRYPTOPUS_TOKEN']
CRYPTOPUS_ACCOUNT = ENV['CRYPTOPUS_ACCOUNT']

MECH = Mechanize.new

#
# Account Login with existing password
#
def login
  page = MECH.get('https://cloudscale.ch/en/')
  page = MECH.click page.link_with(:text => /Login/) # Click the login link
  form = page.forms.first # Select the first form

  form["username"] = CLOUDSCALE_USER
  form["password"] = CLOUDSCALE_PASSWORD
  form["commit"] = "Submit"

  page = form.submit form.buttons.first
  page.uri.to_s.include?('/login') ? false : true
end 

#
# Change password
#
def password_change
  new_pw = SecureRandom.alphanumeric(32)

  page = MECH.get('https://control.cloudscale.ch/security/password')
  form = page.forms.first

  form["old_password"] = CLOUDSCALE_PASSWORD
  form["new_password1"] = new_pw
  form["new_password2"] = new_pw
  form["commit"] = "Save Changes"

  page = form.submit form.buttons.first
  new_pw
end

def get_cryptopus_secret
  resp = Faraday.get("https://cryptopus.puzzle.ch/api/accounts/#{CRYPTOPUS_ACCOUNT}") do |req|
    req.headers['Content-Type'] = 'application/json'
    req.headers['Authorization-User'] = CRYPTOPUS_USER
    req.headers['Authorization-Password'] = Base64.encode64(CRYPTOPUS_TOKEN)
  end
  pp resp
end 

# puts "Login in to account #{ARGV[0]}"
# if login()
#   print "New password: "
#   puts password_change()
#   exit 0
# else
#   puts "ERROR: Login failed!"
#   exit 1
# end

puts get_cryptopus_secret()