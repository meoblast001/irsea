class Users < Application
  provides :xml, :yaml, :js

  # List of quotes a given user has submitted
  def show(id)
    @user = User.get(id)
    raise NotFound unless @user
    @quotes = @user.quotes(:limit => 10, :order => [:posted.desc])
    page_title @user.login
    display @user
  end

  # User registration form
  def new
    only_provides :html
    page_title "register account"
    render
  end

  # Creates a new user account
  def create(user)
    @user = User.new(user)
    # Encrypt password and immediately delete the cleartext version
    @user.encrypt_password
    @user.password = nil
    if @user.save
      redirect "/",
        :message => {:notice => "Account created"}
    else
      message[:error] = "Registration failed"
      render :new
    end
  end

end
