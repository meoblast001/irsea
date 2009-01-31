class Channel
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :length => 64

  belongs_to :network
  has n,      :quotes
end
