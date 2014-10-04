class Plan < ActiveRecord::Base
  
  belongs_to  :supplier
  has_many    :features, dependent: :destroy
  
end
