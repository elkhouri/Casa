class PagesController < ApplicationController
  before_action :signed_in_user
  
  def index
    if current_user.admin?
      redirect_to admin_path
    else
      redirect_to current_user
    end
  end
  
  def feedback
  end
  
  def stats
    @title = "Statistics"
    @times, @times2, @times3 = [],[],[]
    num = Student.count
    num2, num3 = num, num
    for i in 1..30
      @times << [(Time.now+i.day).to_s, num += rand(-4..10)]
      @times2 << [(Time.now+i.day).to_s, num2 += rand(-2..8)]
      @times3 << [(Time.now+i.day).to_s, num3 += rand(-1..3)]
    end
  end
  
  def contact
    @user = current_user
  end

end
