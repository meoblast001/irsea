# irsea - quote.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

# irsea quote
class Quote
  include DataMapper::Resource
  
  property :id,        Serial
  property :title,     String,   :length  => 256, :nullable => false
  property :text,      Text,     :lazy    => false, :nullable => false
  property :posted,    DateTime
  property :spamvotes, Integer,  :default => 0
  property :deleted,   Boolean,  :default => false
  property :upvotes,   Integer,  :default => 0
  property :downvotes, Integer,  :default => 0
  
  has n, :comments
  has n, :tags
  
  belongs_to :user
  belongs_to :network
  belongs_to :channel

  def self.recent
    all(:limit => 10, :order => [:posted.desc], :deleted.not => true)
  end
  
  # Returns a set of random quotes, an optional count may be specified.  Quotes
  # are guaranteed to be unique.
  # This could be made more efficient.
  # @param [Integer] return_count Number of quotes to return
  def self.random(return_count = 10)
    quotes = []
    quote_count = Quote.count
    selected = 0
    
    while selected < [return_count, quote_count].min do
      qid = 1+rand(quote_count)
      quote = Quote.get(qid)
      if quote != nil and quote.deleted != true and quotes.index(quote)
        quotes << quote
        selected += 1
      end
    end
    
    quotes
  end
  
end
