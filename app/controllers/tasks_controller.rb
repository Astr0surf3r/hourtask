class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  
  # GET /tasks or /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.order("id DESC")
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.start_time = task_params["start_time(4i)"] + ":"  + task_params["start_time(5i)"]
    @task.end_time = task_params["end_time(4i)"] + ":"  + task_params["end_time(5i)"]
    respond_to do |format|
      if @task.save
        @project = @task.project 
        format.html { redirect_to project_tasks_path(@project), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      @project = @task.project 
      if @task.update(task_params)
        if @task.closed?
          hours_worked = calculate_hours_worked(@task)
          @task.update(hours_worked: hours_worked)
        end
        format.html { redirect_to project_tasks_path(@project), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @project = @task.project
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def all_tasks
    @tasks = Task.all.order("id DESC").page params[:page]
  end

  def get_tasks_pdf
    
    project = Project.find(params[:id])
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
  
  def get_tasks_xls
  end
  
  def search
    
    term = params[:term]
    @tasks = Task.where("description LIKE ?", "%" + term + "%")

  end

  private
    
    def calculate_hours_worked(task)
      @task = task
      hours_worked = ((@task.start_time.to_time.seconds_until_end_of_day - @task.end_time.to_time.seconds_until_end_of_day)/60).to_f/60
      hours_worked = hours_worked.round(2)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:day,
                                   :start_time,
                                   :end_time,
                                   :description,
                                   :project_id,
                                   :closed)
    end
end
