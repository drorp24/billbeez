class API::Customer 
  
  include Her::Model
  has_many  :bills, class_name: 'API::Bill'
  
end
