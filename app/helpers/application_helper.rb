module ApplicationHelper
  def controller?(*controller) 
    controller.include?(params[:controller])
  end 
      
  def action?(*action)
    action.include?(params[:action])
  end

  def time_format(time)
    time.to_s(:time) rescue "" 
  end 


end
