class Reminder < ActiveRecord::Base
  
  belongs_to      :newsletter
  
end
