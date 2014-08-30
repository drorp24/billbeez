class Charge < ActiveRecord::Base
  
  belongs_to    :notification
  belongs_to    :service
  belongs_to    :comment
  
  def new_service    
  end

  def new_service=(name)
    return unless !name.blank?
    service = Service.create!(name: name)
    update(service_id: service.id)
  end  

  def new_comment    
  end 

  def new_comment=(name)
    return unless !name.blank?
    comment = Comment.create!(name: name)
    update(comment_id: comment.id)
  end 
  
end
