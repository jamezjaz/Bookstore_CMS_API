class BooksController < ApplicationController
  # GET /books

  def index
    @array = []
    @books = Book.all
    @books.map do |book|
      @array.push({
        id: book.id,
        title: book.title,
        author: book.author,
        category: book.category,
        percentage: book.complete_chapters * 100 / book.chapters,
      })
    end

    render json: @array
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
        render json: @book, status: :created, location: @book
    else
        render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    @book = Book.find(params[:id])
    @chapters_complete = @book.complete_chapters < @book.chapters ? @book.complete_chapters+1 : 0
    if @book.update(complete_chapters: @chapters_complete)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :category, :chapters, :complete_chapters)
  end
end
