# irsea - channel.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Channel
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :length => 64

  belongs_to :network
  has n,      :quotes
end
