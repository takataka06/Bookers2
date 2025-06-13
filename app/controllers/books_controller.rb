class BooksController < ApplicationController
  def index
    @books =Book.all
    @book =Book.new
  end

  def show
  end
  def edit
  end
  def update
  end
  def destroy
  end
  def create
    @book =Book.new(book_params)
    @book.user_id = current_user
    if @book.save
      redirect_to books_path,notice: "Book created!"
    else
      @books = Book.all
      flash.now[:alert] = "保存に失敗しました"
      render :index
    end
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
