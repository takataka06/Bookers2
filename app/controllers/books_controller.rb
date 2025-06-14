class BooksController < ApplicationController
  def index
    @books =Book.all
    @book =Book.new
  end

  def show
    @book =Book.find(params[:id])
    @new_book =Book.new
  end
  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
      return
    end
  end
  
  def update
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
      return
    end
  
    if @book.update(book_params)
      flash[:notice] = "Update successfully"
      redirect_to @book
    else
      @books = Book.all
      flash.now[:notice] = "Update error!"
      render :index
    end
  end
  
  def destroy
    @book =Book.find(params[:id])
    if @book.destroy
      flash[:notice] ="Delete successfully"
      redirect_to books_path
    else
      @books =Book.all
      flash.now[:notice] ="Delete error!"
      render :index
    end
  end
  def create
    @book =Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book),notice: "successfully created!"
    else
      @books = Book.all
      flash.now[:alert] = "happen error"
      render :index
    end
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
