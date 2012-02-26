class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    @body_class = "book#{@photo.book_id}"
  end
end