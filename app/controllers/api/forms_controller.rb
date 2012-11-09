class Api::FormsController < Api::ApiController
  
  def index
    forms = Form.all
    render :json => forms
  end
  
  def show
    form = Form.find_by_id(params[:id])
    render :json => form.as_json.merge(:form_fields => form.form_fields.as_json)
  end
  
  def create
    submission = Submission.new
    if params[:form_id]
      submission.form_id = params[:form_id]
    else
      render :json => {:status => "Error", :message => "Form submission invalid: missing form id"}, :status => 406
    end
    data = {}
    submission.data = params[:form].each{|key, value| {key: value} }
    if submission.save
      render :json => { :status => "OK", :message => "Your form was successfully submitted.", :submission_id => submission.id }
    else
      render :json => { :status => "Error", :message => submission.errors }, status => 406
    end
  end
end