class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  
  # GET /tasks or /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.order("day DESC")
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
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path, notice: "Task was successfully created." }
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
      if @task.update(task_params)
        if @task.closed?
          hours_worked = calculate_hours_worked(@task)
          @task.update(hours_worked: hours_worked)
        end
        format.html { redirect_to project_tasks_path, notice: "Task was successfully updated." }
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
    @tasks = Task.all.order("day DESC")
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
