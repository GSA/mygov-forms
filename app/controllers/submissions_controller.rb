class SubmissionsController < ApplicationController
  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission }
      format.pdf {
        pdf = @submission.to_pdf
        if pdf
          send_data pdf, :type => "application/pdf", :filename => File.basename(@submission.form.pdf.url)
        else
          flash[:error] = "There was an error generating your PDF."
          render :submitted
        end
      }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.json
  def create
    form = Form.find_by_number(params[:form_id])
    @submission = Submission.new
    @submission.form = form

    data = {}
    @submission.data = params[:data].each{|key, value| data.merge!(key: value) } if params[:data]
    if @submission.save
      flash[:notice] = "Your form has been submitted."
      redirect_to form_submission_path :id => @submission.id, :form_id => @submission.form_id
    else
      flash[:error] = "Something went horribly wrong."
      render :show
    end

  end

  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to submissions_url }
      format.json { head :no_content }
    end
  end
  
  def assign_submission
    @submission = Submission.find_by_guid(params[:id])
  end

end
