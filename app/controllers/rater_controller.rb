class RaterController < ApplicationController

  def create
    if logged_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_i, @current_user.id.to_s, params[:dimension]
      @object = obj
      Rails.logger.info "----------------------------------------------------------------------"
      Rails.logger.info @object.class
      # render :json => true
      respond_to do |format|
        format.js { render layout: false}
      end      
    else
      render :json => false
    end
  end

end
