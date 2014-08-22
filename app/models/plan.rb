class Plan < ActiveRecord::Base
  
  belongs_to    :newsletter
  has_many      :features
  
end
