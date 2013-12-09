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
    data_table = GoogleVisualr::DataTable.new
    d,t = Date.current, Time.now
    
    # Add Column Headers
    data_table.new_column('date', 'Date' )
    data_table.new_column('timeofday', 'Arrival')
    data_table.new_column('timeofday', 'Departure')

    # Add Rows and Values
    data_table.add_rows([
        [d + 1.day, [t.hour,t.min,t.sec],[t.hour+1,t.min,t.sec]],
        [d + 2.day, [t.hour,t.min,t.sec],[t.hour+1,t.min,t.sec]],
        [d + 3.day, [t.hour,t.min,t.sec],[t.hour+2,t.min,t.sec]],
        [d + 4.day, [t.hour,t.min,t.sec],[t.hour+1,t.min,t.sec]]
    ])
    option = {curveType:'function', title: 'Arrival and Departure Times',
              width:600}
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end
  
  def contact
    @user = current_user
  end

end
