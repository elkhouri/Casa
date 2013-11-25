class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(ID_num: params[:session][:ID_num])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid ID/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
