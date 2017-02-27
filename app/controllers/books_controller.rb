class BooksController < ApplicationController
  def new
    #create a blank book so our views don't freak out.
    @book = Book.new
  end

  #the actual creation logic
  def create
    @book = Book.new(book_params)   #check if the params were legit
    if @book.save
        redirect_to @book
    else
      #save failed. Try again cowboy
      render 'new'
    end

  end

  #show the current book - look it up by id.
  def show
    @book = Book.find(params[:id])
  end

  #show all the books
  def index
    @books = Book.all
  end

  #this is the setup-for-edit, and basically the same as show
  #FIXME - can I collapse this code into show and still have all my auto-routing-thingies work well?
  # since I'll use a partial for the other side.
  def edit
    @book = Book.find(params[:id])
  end

  #the part that actually does the update to the db.
  def update
    #if we don't find the book we'll throw a 404 not found exception automagically.
    #you can make that happen by manually deleting an element.
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  #handy for testing and db cleanup. So including it. Even though it is not part of the assignment
  def destroy
    @book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  #define what the allowed params are so that we don't get other ones from hax0rs.
  def book_params
    params.require(:book).permit(:author, :title, :isbn)
  end


end
