class Api::FormsController < Api::ApiController
  
  def index
    forms = Form.all
    render :json => {:status => "OK", :forms => forms }
  end
  
  def show
    form = Form.find_by_number(params[:id])
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
  
  def fill_pdf
    form = Form.find_by_number(params[:id])
    unless form
      render :json => {:status => "Error", :message => "Form with number: #{params[:id]} not found."}, :status => 404
    else
      unless form.pdf
        render :json => {:status => "Error", :message => "No PDF associated with that form."}, :status => 404
      else
        begin
          pdf_file = form.pdf.fill_in(params[:data])
          send_data pdf_file, :type => "application/pdf", :filename => File.basename(form.pdf.url)
        rescue Exception => e
          render :json => {:status => "Error", :message => e.message }, :status => 500
        end
      end
    end
  end
end