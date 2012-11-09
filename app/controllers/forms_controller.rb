class FormsController < ApplicationController
  
  def index
    @forms = Form.all
  end

  def show
    @form = Form.find_by_id(params[:id])
  end
  
  def create
    @submission = Submission.new
    @submission.form_id = params[:form_id]
    @data = {}
    @submission.data = params[:form].each{|key, value| @data.merge!(key: value) }
    if @submission.save
      flash[:notice] = "Your form has successfully been saved"
      redirect_to submitted_form_path(@submission)
    else
      flash[:error] = "Something went horribly wrong."
      render :show
    end
  end

  def submitted
    @submission = Submission.find_by_id(params[:id])
  end
end
