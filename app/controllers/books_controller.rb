class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @body_class = "book#{@book.id}"
  end
end