
require "securerandom"
require_relative "./cloudscale"
require_relative "./vault_store"
require_relative "./cryptopus_store"

module Pwmate

  def self.generate_password(lenght = 32)
    SecureRandom.alphanumeric(lenght)
  end

  def self.get_current_password(store)
    type = store["type"]
    print "[#{type}-store] "
    case type
    when "cli"
      print "Enter current password: "
      current_password = gets.strip
    when "vault"
      puts "not implemented yet."
      nil
    when "cryptopus"
      puts "not implemented yet."
      nil
    else
      puts "unknown store"
      nil
    end
  end

  def self.set_new_password(store, new_password)
    type = store["type"]
    print "[#{type}-store] "
    case type
    when "cli"
      puts "New password set to '#{new_password}'"
      true
    when "vault"
      puts "not implemented yet."
      false
    when "cryptopus"
      puts "not implemented yet."
      false
    else
      puts "unknown store"
      false
    end
  end

  def self.update_account(account, current_password, new_password)
    case account["type"]
    when "cloudscale.ch"
      cloudscale = CloudScale.new(account["username"], current_password)
      cloudscale.change_password(new_password)
    else
      puts "Unknown account type: '#{account["type"]}'"
      false
    end
  end

end