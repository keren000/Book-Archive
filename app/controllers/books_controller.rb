class BooksController < ApplicationController

  #Index page
  get '/books' do
    if logged_in?
      @user = current_user
      erb :'books/index'
    else
      redirect to '/signup'
    end
  end

  get '/list' do
    if  logged_in?
      @user = current_user
      @books = @user.books.all
      erb :'books/list'
    else
      redirect to '/login'
    end
  end


  #create new book
  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    if params[:title] == ""
      redirect to '/books/new'
    else
      @book = current_user.books.create(title: params[:title], author: params[:author], date: params[:date], format: params[:format])
      redirect to "/list"
    end
  end

  #show one book
  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    if @book
      if logged_in? && @book.user_id == current_user.id
        erb :'/books/show'
      else
        redirect to '/books'
      end
    else
      redirect to '/books'
    end
  end

  #edit a book
  get '/books/:id/edit' do
    @book = Book.find_by_id(params[:id])
    if logged_in? && @book.user_id == current_user.id
      erb :'/books/edit'
    else
      redirect to '/'
    end
  end

  patch '/books/:id' do
    if params[:title] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      @book.update(title: params[:title], author: params[:author], date: params[:date], format: params[:format])
        flash[:notice] = "Your Book Has Been Succesfully Updated!"
      redirect to "/list"
      
    end
  end

  #delete book
  delete '/books/:id/delete' do
    @book = Book.find_by_id(params[:id])
    if logged_in? && @book.user_id == current_user.id
      @book.delete
      flash[:notice] = "Book successfully removed!"
      redirect to '/list'
    else
      redirect to '/books'
    end
  end

  #delete books
   delete '/delete' do
    if logged_in? && @user.books.all == current_user.id
      @book.delete
    else
      redirect to '/login'
    end
  end

end
