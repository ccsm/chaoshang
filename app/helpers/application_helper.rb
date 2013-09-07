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

class ImageCropFormBuilder < ActionView::Helpers::FormBuilder
  def image_crop_hidden(method)
    @template.fields_for :guide_image do |g|
     @template.hidden_field_tag("#{@object_name}[#{g.object_name}_attributes][#{method.to_s}_x]")+
     @template.hidden_field_tag("#{@object_name}[#{g.object_name}_attributes][#{method.to_s}_y]")+
     @template.hidden_field_tag("#{@object_name}[#{g.object_name}_attributes][#{method.to_s}_w]")+
     @template.hidden_field_tag("#{@object_name}[#{g.object_name}_attributes][#{method.to_s}_h]")
    end
  end
 end

