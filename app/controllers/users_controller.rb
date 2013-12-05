class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :parent, :child, :profile]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :admin]
  
  def parent
    @title = "Parents"
    @user = User.find(params[:id])
    @users = @user.parents.paginate(page: params[:page])
    render 'show_parent'
  end

  def child
    @title = "Children"
    @user = User.find(params[:id])
    @users = @user.children.paginate(page: params[:page])
    render 'show_parent'
  end
  
  def profile
    @user = User.find(params[:id])
    @title = @user.name
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
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Casa!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
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
                                   :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
