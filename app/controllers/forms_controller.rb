class FormsController < ApplicationController

  def index
    @forms = Form.all
  end

  def show
    @form = Form.find_by_number(params[:id])
  end

  def submission
    @form = Form.find_by_number(params[:id])
  end
end
