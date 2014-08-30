class Comment < ActiveRecord::Base
  
  has_many    :charges
  
end
