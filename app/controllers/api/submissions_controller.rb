class Api::SubmissionsController < Api::ApiController
  before_filter :assign_form
  respond_to :json, :xml
  
  def show
    unless @form
      render :json => {:status => "Error", :message => "Invalid form number."}, :status => 404
    else
      submission = @form.submissions.find_by_guid(params[:id])
      if submission
        respond_with submission
      else
        render :json => {:status => "Error", :message => "Submission with id=#{params[:id]} not found."}, :status => 404
      end
    end
  end
  
  def create
    unless @form
      render :json => {:status => "Error", :message => "Form submission invalid: missing valid form id"}, :status => 406
    else
      submission = @form.submissions.new(params[:submission])
      if submission.save
        respond_with submission.to_json(:only => :guid), :location => api_form_submission_url(@form, submission)
      else
        render :json => { :status => "Error", :message => submission.errors }, status => 406
      end
    end
  end
  
  private
  
  def assign_form
    @form = Form.find_by_number(params[:form_id])
  end
end