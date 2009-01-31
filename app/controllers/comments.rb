class Comments < Application

  # Action for comment submission form
  def create(quote_id, comment)
    @comment = Comment.new(comment)
    @quote   = Quote.get(quote_id)
    @comment.quote = @quote
    @comment.posted = Time.now
    @comment.user = session.user if session.authenticated?
    if @comment.save
      redirect resource(@quote), :message =>
        {:notice => "Comment was successfully created"}
    else
      redirect resource(@quote), message=>
        {:error => "Comment failed to be created"}
    end
  end
  
end
