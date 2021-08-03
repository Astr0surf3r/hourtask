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
    
    projects = Project.all
    project_detail_html = ""
    html = File.read(Rails.root.join('app/assets/files/receipt.html'))
    
    projects.order("name ASC").each do |project|
    project_detail_html += "
                            <tr>
                              <td class='Fuente11'>#{project.name}</td>
                              <td class='Fuente11'>#{helpers.number_to_currency(project.hourly_rate, unit: '$ ', separator: ',', delimiter: '')}</td>
                              <td class='Fuente11'>#{project.currency}</td>
                              <td class='Fuente11'>#{helpers.calculate_project_hours_worked(project).round(2)}</td>
                              <td class='Fuente11'>#{helpers.calculate_project_hours_paid(project).round(2)}</td>
                              <td class='Fuente11'>#{(helpers.calculate_project_hours_worked(project)- helpers.calculate_project_hours_paid(project)).round(2)}</td>
                              <td class='Fuente11'>#{helpers.number_to_currency(helpers.calculate_project_amount_hours_paid(project), unit: '$ ', separator: ',', delimiter: '.')}</td>
                              <td class='Fuente11'>#{helpers.number_to_currency(helpers.calculate_project_amount_hours_unpaid(project), unit: '$ ', separator: ',', delimiter: '.')}</td>                                                      
                            </tr>"
    end
    
    html.gsub! "[[Website]]", "Italianolab.com"
    html.gsub! "[[Date]]", Time.now.strftime('%d/%m/%Y')
    html.gsub! "[[Item]]", project_detail_html
    html.gsub! "[[AmountPaid]]", "#{helpers.number_to_currency(helpers.calculate_project_total_amount_hours_paid, unit: '$ ', separator: ',', delimiter: '.')}"
    html.gsub! "[[AmountUnPaid]]", "#{helpers.number_to_currency(helpers.calculate_project_total_amount_hours_unpaid, unit: '$ ', separator: ',', delimiter: '.')}"
    @pdf = WickedPdf.new.pdf_from_string(html.clone,
                                         margin: {
                                             top: '0.25in',
                                             bottom: '0.25in',
                                             right: '0.25in',
                                             left: '0.25in'
                                         })

    send_data @pdf, type: 'application/pdf', disposition: 'inline'

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

    def calculate_project_total_amount_hours_paid
      @projects = Project.all
      total_amount_projects = Array.new
      @projects.each do |project| 
        amount = calculate_project_amount_hours_paid(project)
        total_amount_projects << amount
      end
      
      total_amount_hours_paid = total_amount_projects.inject(0){|sum,x| sum + x }
    end

    def calculate_project_total_amount_hours_unpaid
      @projects = Project.all
      total_amount_projects = Array.new
      @projects.each do |project| 
        amount = calculate_project_amount_hours_unpaid(project)
        total_amount_projects << amount
      end
      
      total_amount_hours_unpaid = total_amount_projects.inject(0){|sum,x| sum + x }
    end
    
    def calculate_project_amount_hours_paid(project)
      
      @project = project
      
      unless @project.payment_items.blank?
        amount_paid = (@project.previous_hours_paid + Project.last.payment_items.sum(:hours_paid)) * @project.hourly_rate 
      else
        amount_paid = @project.previous_hours_paid * @project.hourly_rate
      end
        
    end

    def calculate_project_amount_hours_unpaid(project)
      
      @project = project
      
      total_amount = calculate_project_hours_worked(@project) * @project.hourly_rate 
      amount_paid = calculate_project_amount_hours_paid(@project)
      
      amount_unpaid = total_amount - amount_paid

    end

    def calculate_project_hours_worked(project)
      
      @project = project
    
      if @project.previous_hours_worked == 0.0
        hours_worked = project.tasks.sum(:hours_worked)
      else
        hours_worked = @project.previous_hours_worked + @project.tasks.sum(:hours_worked)
      end 
    
    end
    
    def calculate_project_hours_paid(project)
    
      @project = project
      
      if @project.previous_hours_paid == 0.0
        hours_payed = @project.payment_items.sum(:hours_paid)
      else
        hours_payed = @project.previous_hours_paid + @project.payment_items.sum(:hours_paid)
      end
    
    end

end
