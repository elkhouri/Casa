class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :parent, :child, :profile]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :admin]
  
  def profile
    @user = User.find(params[:id])
    @title = @user.name
    @attendances = @user.attendances.to_a
    @pickup_times = @attendances.select{|a| not a.pickup_time.nil?}
      .map{|x| [x.pickup_time.to_date.to_s,x.pickup_time.to_s(:time)]}
      
    @dropoff_times = @attendances.select{|a| not a.dropoff_time.nil?}
      .map{|x| [x.dropoff_time.to_date.to_s,x.dropoff_time.to_s(:time)]}
      
    @subjects = Subject.all.map{|x| [x.name, @attendances.select{|a| a.subject_id == x.id}.count]}
    
    if @user.is_a?(Student)
    @dropoffs = @attendances.uniq{|x| x.dropoff_id}.first(3)
      .map{|x| [x.dropoff.name, @attendances.select{|a| a[:dropoff_id] == x.dropoff.id}.count]}
      
    @pickups = @attendances.uniq{|x| x.pickup_id}.first(3)
      .map{|x| [x.pickup.name, @attendances.select{|a| a[:pickup_id] == x.pickup_id}.count]}
    end
  end

  def calendar
    respond_to do |format|
      format.js 'aa'
    end
  end
  
  def score
    @title = 'Score Cards'
    @user = User.find(params[:id])
  end
  
  def admin
    @parents = Parent.paginate(page: params[:page])
    @students = Student.paginate(page: params[:page])
    @volunteers = Volunteer.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    
    if current_user.is_a?(Student)
      render 'show_student'
    elsif current_user.is_a?(Volunteer)
      render 'show_volunteer'
    elsif current_user.is_a?(Parent)
      @children = @user.children.paginate(page: params[:page])
      render 'show_parent'
    end
  end
  
  def index
    @parents = Parent.paginate(page: params[:page])
    @students = Student.paginate(page: params[:page])
    @volunteers = Volunteer.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Casa!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @title = 'Edit Profile'
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :ID_num, :password,
                                   :password_confirmation, :type, :email,
                                   :grade, :phone, :address, :interest,
                                   :specialization, :note)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) and flash[:danger] = "You cannot do that" unless current_user?(@user) or current_user.is_a?(Admin)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
