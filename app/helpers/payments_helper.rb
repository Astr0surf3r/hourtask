module PaymentsHelper
  
  def retrieve_projects(payment)
    
    project_array = payment.payment_items.pluck(:project_id)
    project_name = Array.new
    project_array.each do |project|
      project_name << Project.find(project).name
    end
    
    project_name.join(", ")

  end
end
