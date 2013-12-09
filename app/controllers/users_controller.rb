class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :parent, :child, :profile]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :admin]
  
  def profile
    @user = User.find(params[:id])
    @title = @user.name
    @attendances = @user.attendances.all
    @attendance_chart = attendances_chart(@attendances)
    if @user.is_a?(Student)
    @subject_pie = subjects_pie(@attendances)
    @dropoff_pie = dropoffs_pie(@attendances)
    @pickup_pie = pickups_pie(@attendances)
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
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def attendances_chart(collection)
      data_table = GoogleVisualr::DataTable.new
      
      data_table.new_column('date', 'Date' )
      data_table.new_column('timeofday', 'Arrival Time')
      data_table.new_column('timeofday', 'Departure Time')
      
      collection.each do |a|
        st,et = a.dropoff_time.in_time_zone('America/Los_Angeles'), a.pickup_time.in_time_zone('America/Los_Angeles')

        data_table.add_rows([[st.to_date, [st.hour,st.min,st.sec],[et.hour+1,et.min,et.sec]]])
      end
      option = {curveType:'function', title: 'Arrival and Departure Times / La Horas de Llegada y Salida', width:1100
                }
       return GoogleVisualr::Interactive::LineChart.new(data_table, option)
    end
    
    def subjects_pie(collection)
      data_table = GoogleVisualr::DataTable.new
      
      data_table.new_column('string', 'Subject' )
      data_table.new_column('number', 'Number')
      data_table.add_rows(Subject.count)
      
      Subject.all.each_with_index do |s,i|
        data_table.set_cell(i, 0, s.name)
        data_table.set_cell(i, 1, collection.select{|a| a[:subject_id] == s.id}.count)
      end
      option = {title: 'Subjects / Temas', width:300
                }
       return GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end

    def dropoffs_pie(collection)
      c = collection.uniq{|x| x.dropoff_id}
      data_table = GoogleVisualr::DataTable.new
  
      data_table.new_column('string', 'Parents' )
      data_table.new_column('number', 'Number')
      data_table.add_rows(c.count)
    
      c.each_with_index do |d,i|
        data_table.set_cell(i, 0, d.dropoff.name)
        data_table.set_cell(i, 1, collection.select{|a| a[:dropoff_id] == d.dropoff.id}.count)
      end
      option = {title: 'Who Dropped Off / Quien Bajar', width:300
                }
       return GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end
    
    def pickups_pie(collection)
      c = collection.uniq{|x| x.pickup_id}
      data_table = GoogleVisualr::DataTable.new
  
      data_table.new_column('string', 'Parents' )
      data_table.new_column('number', 'Number')
      data_table.add_rows(c.count)
    
      c.each_with_index do |d,i|
        data_table.set_cell(i, 0, d.pickup.name)
        data_table.set_cell(i, 1, collection.select{|a| a[:dropoff_id] == d.pickup.id}.count)
      end
      option = {title: 'Who Picked Up / Quien Ligarse', width:300
                }
       return GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end   
end
