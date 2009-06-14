# irsea - network.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Network
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :length => 64
  property :user_network, Boolean, :default => false
  
  has n, :channels
  has n, :quotes

end
