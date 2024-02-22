class MoviesController < ApplicationController
  def index
    if params[:q].present?
      sql_query = <<~SQL
      title @@ :q OR
      synopsis @@ :q OR
      directors.first_name @@ :q OR
      directors.last_name @@ :q
      SQL
      @movies = Movie.joins(:director) # this works because Movie belongs_to :director
                     .where(sql_query, q: "%#{params[:q]}%")
    else
      @movies = Movie.all
    end
  end
end
