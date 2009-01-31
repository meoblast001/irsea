class Comment
  include DataMapper::Resource
  
  property :id,     Serial
  property :text,   Text, :lazy => false
  property :posted, DateTime
  
  belongs_to :user
  belongs_to :quote

end
