class Api::FormsController < Api::ApiController
  respond_to :json, :xml
  
  def index
    respond_with Form.all
  end
  
  def show
    form = Form.find_by_number(params[:id])
    if form
      respond_with form.as_json.merge(:form_fields => form.form_fields.as_json)
    else
      render :json => {:status => "Error", :message => "Form with id=#{params[:id]} not found"}, :status => 404
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
          Rails.logger.error(e)
          render :json => {:status => "Error", :message => e.message }, :status => 500
        end
      end
    end
  end
end