class SessionsController < ApplicationController
  def new
  end

  def create
    member_profile = MemberProfile.find_by_username(params[:username])
    if member_profile && member_profile.authenticate(params[:password])
      session[:user_id] = member_profile.user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Name or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
