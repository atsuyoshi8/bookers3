class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path, success: '登録ができました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @user = User.find(params[:id])
  if@user.update(user_params)
    flash[:notice] = "投稿に成功しました。"
    redirect_to users_path(@user.id)
  else
    flash[:alret] = "投稿に失敗しました。"
    render "index"
  end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:alert] = "ログアウトしました"
    redirect_to :root
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
