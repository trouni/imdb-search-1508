class MoviesController < ApplicationController
  def index
    @movies = Movie.all # select all movies if no query is passed

    ## PG Search Implementation
    @movies = @movies.search(params[:q]) if params[:q].present?

    ## If you need to add further filters:
    # @movies = @movies.where(category: params[:category]) if params[:category].present?
    # @movies = @movies.near(params[:location]) if params[:location].present?

    ## SQL Implementation
    #
    # sql_query = <<~SQL
    # title @@ :q OR
    # synopsis @@ :q OR
    # directors.first_name @@ :q OR
    # directors.last_name @@ :q
    # SQL
    # @movies = Movie.joins(:director) # this works because Movie belongs_to :director
    #                .where(sql_query, q: "%#{params[:q]}%") if params[:q].present?
  end
end
