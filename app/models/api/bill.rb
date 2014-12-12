class API::Bill 
  
  include Her::Model
  belongs_to  :customer, class_name: "API::Customer" 
end
