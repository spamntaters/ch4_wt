class MoviesController < ApplicationController
  def create
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)
    #@movie = Movie.create!(params[:movie]) #old way
    @movie = Movie.create!(movie_params)  # new way
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def index
    @movies = Movie.all
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end
  
  def edit
    @movie = Movie.find params[:id]
  end

  def update
  @movie = Movie.find params[:id]
  @movie.update_attributes!(movie_params)
  respond_to do |client_wants|
    client_wants.html {  redirect_to movie_path(@movie)  } # as before
    client_wants.xml  {  render :xml => @movie.to_xml    }
  end
end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def new
    @movie = Movie.new
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end