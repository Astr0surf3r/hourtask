module ProjectsHelper
  
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
  
  def calculate_project_amount_hours_paid(project)
    
    @project = project

    unless @project.payment_items.blank?
      amount_paid = (@project.previous_hours_paid + @project.payment_items.sum(:hours_paid)) * @project.hourly_rate 
    else
      amount_paid = @project.previous_hours_paid * @project.hourly_rate 
    end
    
    return amount_paid

  end

  def calculate_project_amount_hours_unpaid(project)
    
    @project = project
    
    total_amount = calculate_project_hours_worked(@project) * @project.hourly_rate 
    amount_paid = calculate_project_amount_hours_paid(@project)
    
    amount_unpaid = total_amount - amount_paid

  end
  
  def calculate_project_total_amount
    @projects = Project.all
    total_amount_projects = Array.new
    @projects.each do |project| 
      amount = calculate_project_amount_hours_paid(project) + calculate_project_amount_hours_unpaid(project)
      total_amount_projects << amount
    end
    
    total_amount = total_amount_projects.inject(0){|sum,x| sum + x }
  
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

end
