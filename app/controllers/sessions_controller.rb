class SessionsController < ApplicationController

  def new
    #redirect_to '/auth/facebook'
    #or google -- figure out which one and when
  end

  def create
    auth = request.env["omniauth.auth"]
    unless auth.nil?

      user = User.where(:provider => auth['provider'],
                        :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      reset_session
      session[:user_id] = user.id
      session[:auth_token] = auth.access_token
      redirect_to '/', :notice => 'Signed in!'
    else
      require "open-uri"
      non_omniauth_code = request[:code]
      header = Hash.new
      header["Authorization"] = "tJ7h69WytTSbPA:XHtTY9IQA-IfK77Nnesol3987DE"
      header["User-Agent"] = "I eat donkey balls"
      header["grant_type"] = "grant_type=authorization_code&code=#{non_omniauth_code}&redirect_uri=http://localhost:3000/user"
      response = open("https://oauth.reddit.com/api/v1/me", headers = header).read
      puts response
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
