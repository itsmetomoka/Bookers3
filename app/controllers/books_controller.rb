class BooksController < ApplicationController
  before_action :authenticate_user!
  
	def create
		@book= Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "posted successfully"
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
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "your post was updated successfully"
    redirect_to book_path(@book.id)
    else
      render :edit
      
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
    flash[:notice] ="your post was deleted successfully"
  	redirect_to user_path(current_user.id)
  end
  private
  def book_params
  	params.require(:book).permit(:title,:body)
  end
end
