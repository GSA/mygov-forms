class Api::FormsController < Api::ApiController
  
  def index
    forms = Form.all
    render :json => {:status => "OK", :forms => forms }
  end
  
  def show
    form = Form.find_by_id(params[:id])
    if form
      render :json => {:status => "OK", :form => form.as_json.merge(:form_fields => form.form_fields.as_json)}
    else
      render :json => {:status => "Error", :message => "Form with id=#{params[:id]} not found"}, :status => 404
    end
  end
  
  def create
    unless params[:form_id]
      render :json => {:status => "Error", :message => "Form submission invalid: missing form id"}, :status => 406
    else
      submission = Submission.new
      submission.form_id = params[:form_id]
      data = {}
      submission.data = params[:form].each{|key, value| data.merge!(key: value) } if params[:form]
      if submission.save
        render :json => { :status => "OK", :message => "Your form was successfully submitted.", :submission_id => submission.guid }
      else
        render :json => { :status => "Error", :message => submission.errors }, status => 406
      end
    end
  end
end