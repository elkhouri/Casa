class AttendancesController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @user.attends!(current_user, params)
    if current_user.is_a?(Parent)
      flash[:success] = @user.name << " Has Been Checked In"
    else
      flash[:success] = "You Checked In"
    end
    redirect_to :back
  end
  
  def update
    @attendance = Attendance.find(params[:id])
    @user = User.find(params[:user_id])
    if current_user.is_a?(Parent)
      @attendance.update_attributes(pickup_time: Time.current(), pickup: current_user)
      flash[:warning] = @user.name << " Has Been Checked Out"
    else
      @attendance.update_attributes(pickup_time: Time.current())
      flash[:warning] = "You Checked Out"
    end
    
    redirect_to :back
  end
end
