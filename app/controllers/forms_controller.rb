class FormsController < ApplicationController
  before_filter :assign_submission, :only => [:submitted, :pdf]
  
  def index
    @forms = Form.all
  end

  def show
    @form = Form.find_by_number(params[:id])
  end
  
  def create
    @submission = Submission.new
    @submission.form_id = params[:form_id]
    data = {}
    @submission.data = params[:form].each{|key, value| data.merge!(key: value) } if params[:form]
    if @submission.save
      flash[:notice] = "Your form has been saved successfully."
      redirect_to submitted_form_path(@submission)
    else
      flash[:error] = "Something went horribly wrong."
      render :show
    end
  end

  def submitted
  end
  
  def pdf
    pdf = @submission.to_pdf
    if pdf
      send_data pdf, :type => "application/pdf", :filename => File.basename(@submission.form.pdf.url)
    else
      flash[:error] = "There was an error generating your PDF."
      render :submitted
    end
  end
  
  private
  
  def assign_submission
    @submission = Submission.find_by_guid(params[:id])
  end
end