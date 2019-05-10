require 'rack-flash'

class ShowsController < ApplicationController
  use Rack::Flash

  get '/shows' do
    if logged_in?
      @shows = current_user.shows.order(:title)
      @show_scores = current_user.shows.order(score: :desc)
      erb :'shows/shows'
    else
      redirect to '/login'
    end
  end

  get '/shows/new' do
    if logged_in?
      erb :'/shows/new'
   else
     redirect to '/login'
   end
 end

 post '/shows' do
   if logged_in?
     @show = current_user.shows.new(:title => params[:title], :score => params[:score], :status => params[:status])
      if params[:title] != ""
        @show.save
        redirect("/shows/#{@show.id}")
      else
        redirect to "/shows/new"
      end
    else
      redirect to "/login"
    end
  end

  get '/shows/:id' do
    if logged_in?
      @show = Show.find_by(id: params[:id])
      erb :'/shows/show_show'
    else
      redirect to "/login"
    end
  end

  get '/shows/:id/edit' do
    if logged_in?
      @show = current_user.shows.find_by(id: params[:id])
      erb :'/shows/edit_show'
    else
      redirect to "/login"
    end
  end

  patch '/shows/:id' do
    if logged_in?
      @show = current_user.shows.find_by(id: params[:id])
      if params[:title] != ""
        if @show && @show.user == current_user
        @show.update(:title => params[:title], :score => params[:score], :status => params[:status])

        redirect("/shows/#{@show.id}")
      else
        redirect("/shows/#{@shows.id}/edit")
        end
      end
    else
      redirect to "/login"
    end
  end

  delete '/shows/:id/delete' do
    if logged_in?
      @show = current_user.shows.find_by(id: params[:id])
        if @show && @show.user == current_user
          @show.delete
        end
      flash[:message] = "Anime successfully deleted."
      redirect to "/shows"
    else
      redirect to "/login"
    end
  end

end
