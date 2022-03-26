module DiscountsHelper
  
  def calculus_discounted_value(discount)
    
    project = discount.project
    hourly_rate = project.hourly_rate 

    value = hourly_rate * discount.discounted_hours

  end

  def retrieve_currency_symbol(project)
  
    currency = project.currency 
    symbols = {"USD" => "$", "MXN" => "$"}

    symbols.each do |key, value|

      return value if key == currency 
    
    end

  end

end
