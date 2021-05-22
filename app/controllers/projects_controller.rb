class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all.order("name ASC")
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to root_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_path, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def welcome

  end
  
  def get_pdf

    #html = File.read(Rails.root.join('app/assets/files/receipt.html'))

    #@pdf = WickedPdf.new.pdf_from_string(html.clone,
    #                                       margin: {
    #                                           top: '0.25in',
    #                                           bottom: '0.25in',
    #                                           right: '0.25in',
    #                                           left: '0.25in'
    #                                       }
    #                                    )

    #send_data @pdf, type: 'application/pdf', disposition: 'inline' 
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ProjectsPdf.new
        send_data pdf.render, filename: "ciao.pdf", type: "application/pdf"
      end
    end

  end
  
  def get_xls

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name,
                                      :hourly_rate,
                                      :currency,
                                      :company_id,
                                      :previous_hours_worked,
                                      :previous_hours_paid)
    end
end
