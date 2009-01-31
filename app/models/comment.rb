# irsea - comment.rb
# Author    :: Stefan Nuxoll
# License   :: BSD license
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Comment
  include DataMapper::Resource
  
  property :id,     Serial
  property :text,   Text, :lazy => false
  property :posted, DateTime
  
  belongs_to :user
  belongs_to :quote

end
