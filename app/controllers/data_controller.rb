class DataController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only => [:index_preflight]

   def set_cors_headers
     headers["Access-Control-Allow-Origin"] = "*"
     headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
     headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
     headers["Access-Control-Max-Age"] = "3600"
   end
	
   def index_preflight
     if Stat.exists?(:pathname => params[:pathname],:host => params[:host])
	@stat = Stat.where(:pathname => params[:pathname],:host => params[:host]).first
	@stat.visits = @stat.visits + 1
        @stat.averagetime = (@stat.averagetime * (@stat.visits - 1) + (params[:time].to_i / 1000)) / @stat.visits
        @stat.save
     else
	@stat = Stat.new
	@stat.pathname = params[:pathname]
	@stat.host = params[:host]
	@stat.visits = 1
        @stat.averagetime = (params[:time].to_i / 1000) 
        @stat.save
     end
     set_cors_headers
     render :text => "", :content_type => "text/plain"
   end

  private
   def stat_params
    params.permit(:pathname, :host, :time)
   end

end
