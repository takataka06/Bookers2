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
  end
  def update
    @book =Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="Update succesfully"
      redirect_to @book
    else
      @books =Book.all
      flash.now[:notice] ="Update error!"
      render :index
    end
  end
  def destroy
    @book =Book.find(params[:id])
    if @book.destroy
      flash[:notice] ="Delete succesfully"
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
      redirect_to books_path,notice: "successfully created!"
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
