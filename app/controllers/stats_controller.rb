class StatsController < ApplicationController
  def index
   @stats = Stat.all
  end

  def show
    @stat = Stat.find(params[:id])
  end

  def new
    @stat = Stat.new(stat_params)
    @stat.visits = 1
    @stat.save
    redirect_to action:"index"
  end

  private
    def stat_params
      params.permit(:pathname, :averagetime, :host)
    end
end
