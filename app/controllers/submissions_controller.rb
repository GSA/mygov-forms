class SubmissionsController < ApplicationController
  before_filter :assign_form
  before_filter :assign_submission, :only => [:show]
  
  def show
    @submission = Submission.find_by_guid(params[:id])
    respond_to do |format|
      format.html
      format.pdf {
        pdf = @submission.to_pdf
        if pdf
          send_data pdf, :type => "application/pdf", :filename => File.basename(@submission.form.pdf.url)
        else
          flash[:error] = "There was an error generating your PDF."
          redirect_to :back
        end
      }
    end
  end

  def create
    @submission = @form.submissions.new
    data = {}
    @submission.data = params[:data].each{|key, value| data.merge!(key: value) } if params[:data]
    if @submission.save
      flash[:notice] = "Your form has been submitted."
      redirect_to form_submission_path(@form, @submission)
    else
      flash[:error] = "Something went horribly wrong."
      render :show
    end

  end

  private
  
  def assign_form
    @form = Form.find_by_number(params[:form_id])
  end
  
  def assign_submission
    @submission = Submission.find_by_guid(params[:id])
  end
end
