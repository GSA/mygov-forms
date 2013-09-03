class FormsController < ApplicationController

  def index
    @forms = Form.all
  end

  def show
    @form = Form.find_by_number(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

    @navigation_items = ActiveSupport::OrderedHash.new
    @navigation_items[:start_content] = {title:"Before You Start", link:"start"}
    @navigation_items[:need_to_know_content] = {title:"What You Need to Know", link:"what_you_need"}
    @navigation_items[:ways_to_apply_content] = {title:"Other Ways to Apply", link:"ways_to_apply"}

  end

  def start
    @form = Form.find_by_number(params[:id])
  end
end
