#FIXME - we should probably move the "read" feature to a separate model/table because it's not really tied to a rating.
# each read should can have one rating. Each rating must have a read.
# it is not necessary to have a read a book to have said book on your shelf. Of course, then the converse can be true. I can have read a book, and it might not be on my shelf. So really we would need to further divide this into "books", "shelfs", "ratings". And a shelf would be user:book:read, along with ratings potentially from that user.
# but this was not really in our original spec. but in implementing this - if we're building the equivalent of "goodreads" this would be where we want
# to take it.

class RatingsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @rating = Rating.new()
  end

  def create
    @book = Book.find(params[:book_id])
    @rating = @book.ratings.create(rating_params)
    if @rating.save
      redirect_to book_path(@book)
    else
      #save failed. rerender with errors
      render 'new'
    end
  end

  # not implementing editing a rating that is old. Just delete the bad boy.
  # edit
  # update
  #

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    #go back to the book in question.
    redirect_to book_path
  end

  private
  #this will need to be extended to include User at some point
  #USER_EXTEND
  def rating_params
    params.require(:rating).permit(:was_read, :rating)
  end



end
