class Network
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :length => 64
  
  has n, :channels
  has n, :quotes

end
