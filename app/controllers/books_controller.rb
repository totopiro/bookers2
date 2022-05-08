class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
    #index部分
    @books = Book.all

    #new部分
    @book = Book.new

    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def show
    @book1 = Book.find(params[:id])
    @book2 = Book.new
    @user = @book1.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to books_path unless @user == current_user
  end
end
