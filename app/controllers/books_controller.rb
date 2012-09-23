class BooksController < ApplicationController
  caches_action :show, :cache_path => Proc.new { |c| "show_book_#{c.params[:id]}" }
  
  def show
    @book = Book.find(params[:id])
    @body_class = "book#{@book.id}"
  end
end