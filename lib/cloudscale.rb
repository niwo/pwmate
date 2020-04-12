require "mechanize"

  class CloudScale

    def initialize(username, password)
      @username = username.to_s
      @password = password.to_s
      @mech = Mechanize.new
      @mech.user_agent = "pwmate"
      @logged_in = false
    end

    #
    # Account Login with existing password
    #
    def login
      if @password.empty?
        raise "missing password for cloudscale.ch account #{@username}."
      end

      page = @mech.get('https://cloudscale.ch/')
      page = @mech.click page.link_with(:text => /Login/) # Click the login link
      form = page.forms.first # Select the first form

      form["username"] = @username
      form["password"] = @password
      form["commit"] = "Submit"

      page = form.submit form.buttons.first
      @logged_in = page.uri.to_s.include?('/login') ? false : true
    end 

    #
    # Change password
    #
    def change_password(new_password)
      login() unless @logged_in
      if @logged_in
        page = @mech.get('https://control.cloudscale.ch/security/password')
        form = page.forms.first

        form["old_password"] = @password
        form["new_password1"] = new_password
        form["new_password2"] = new_password
        form["commit"] = "Save Changes"

        page = form.submit form.buttons.first
        page.code.to_i == 200
      else
        false
      end
    end
  end