class LinksController < ApplicationController
  def show
    if params[:shortcode]
      @link = Link.find_by(shortcode: params[:shortcode])
      if @link
        @link.update(last_accessed: Time.now, access_count: @link.access_count + 1)
        redirect_to @link.url if @link
      else
        render plain: "Invalid link", status: :unprocessable_entity
      end
    # else
    #   render plain: "Welcome to shortster"
    end
  end
  
  def create
    @link = Link.new(link_params)
    @link.shortcode = Link.generate_shortcode if params[:shortcode].nil?
    if @link.save!
      json_response({
        data: @link,
        message: "Link created",
        errMessage: nil
      }, :created)
    end
  rescue ActiveRecord::RecordInvalid => e
    json_response({
      data: nil,
      message: "Error",
      errMessage: e
    }, :unprocessable_entity)
  end

  def stats
    @shortcode_stats = Link.find_by(shortcode: params[:shortcode])
    json_response({
      data: @shortcode_stats,
      message: "",
      errMessage: nil
    })
  end

  private

  def link_params
    params.permit(:url, :shortcode)
  end
end
