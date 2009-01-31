# irsea - user.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class User
  include DataMapper::Resource
 
  property :id,       Serial
  property :login,    String, :length => 64
  property :email,    String, :length => 256
  property :password, String, :length => 256
  property :admin,    Boolean, :default => false

  validates_is_unique :login
  validates_is_unique :email
  validates_present   :login
  validates_present   :email
  
  has n, :quotes
  has n, :comments
end
