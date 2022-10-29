class BooksController < ApplicationController
  def new
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "投稿に成功しました。"
    redirect_to book_path(@book)
  else
    flash[:alret] = "投稿に失敗しました。"
    @books = Book.all
    render "index"
  end
  end

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def show
    @book=Book.find(params[:id])
    @books=Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
  if@book.update(book_params)
     flash[:notice] = "投稿に成功しました。"
    redirect_to books_path(@book.id)
  else
    flash[:alret] = "投稿に失敗しました。"
    @books = Book.all
    render "edit"
  end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :image)
  end

end
