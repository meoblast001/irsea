class Tag
  include DataMapper::Resource
  
  property :id,   Serial
  property :text, String, :length => 32

  belongs_to :quote
end
