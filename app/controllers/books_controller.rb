class BooksController < ApplicationController
	def create
		@book= Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
    redirect_to user_path(current_user.id)
    else
      @books=Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books =Book.all
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to user_path(current_user.id)
  end
  private
  def book_params
  	params.require(:book).permit(:title,:opinion,)
  end
end