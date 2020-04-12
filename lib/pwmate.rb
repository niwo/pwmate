
require "securerandom"
require "vault"
require_relative "./cloudscale"
require_relative "./cryptopus_store"

class Pwmate

  def initialize(options = {})
    @options = options
  end

  def generate_password(lenght = 32)
    SecureRandom.alphanumeric(lenght)
  end

  def get_current_password(store)
    type = store["type"]
    print "[#{type}-store] "
    case type
    when "cli"
      print "Enter current password: "
      current_password = gets.strip
    when "vault"
      secret = Vault.logical.read(store["path"])
      puts "Retrieved secret"
      secret.data[:data][store["key"].to_sym]
    when "cryptopus"
      puts "Retrieving secret"
      cryptopus = CryptopusStore.new(
        store["user"],
        ENV['CRYPTOPUS_TOKEN'],
        @options
      )
      cryptopus.get_secret(store["account"])
    else
      puts "unknown store"
      nil
    end
  end

  def set_new_password(store, new_password)
    type = store["type"]
    print "[#{type}-store] "
    case type
    when "cli"
      puts "New password set to '#{new_password}'"
      true
    when "vault"
      data = Vault.logical.read(store["path"]).data[:data]
      data.merge!(store["key"].to_sym => new_password)
      puts "Saving secret..."
      Vault.logical.write(store["path"], data: data)
    when "cryptopus"
      cryptopus = CryptopusStore.new(
        store["user"],
        ENV['CRYPTOPUS_TOKEN'],
        @options
      )
      puts "Saving secret"
      cryptopus.set_secret(store["account"], new_password)
    else
      puts "unknown store"
      false
    end
  end

  def update_account(account, current_password, new_password)
    case account["type"]
    when "cloudscale.ch"
      cloudscale = CloudScale.new(account["username"], current_password)
      cloudscale.change_password(new_password)
    else
      puts "Unknown account type: '#{account["type"]}'"
      false
    end
  end

  def login_account(account, current_password)
    case account["type"]
    when "cloudscale.ch"
      cloudscale = CloudScale.new(account["username"], current_password)
      cloudscale.login
    else
      puts "Unknown account type: '#{account["type"]}'"
      false
    end
  end

end