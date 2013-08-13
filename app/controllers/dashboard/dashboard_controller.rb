class Dashboard::DashboardController < InheritedResources::Base
   before_filter :authenticate_admin! 
   respond_to :html
end
