# irsea - tag.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Tag
  include DataMapper::Resource
  
  property :id,   Serial
  property :text, String, :length => 32

  belongs_to :quote
end
