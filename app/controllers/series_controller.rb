class SeriesController < ApplicationController

  get '/anime' do
    if logged_in?
      @anime = anime.all
      erb :'anime/anime'
    else
      redirect to '/login'
    end
  end

  get '/anime/new' do
    if logged_in?
      erb :'/anime/new'
   else
     redirect to '/login'
   end
 end

 post '/anime' do
   if logged_in?
     @anime = current_user.anime.new(:content => params[:content])
      if params[:content] != ""
        @anime.save
        redirect("/anime/#{@anime.id}")
      else
        redirect to "/anime/new"
      end
    else
      redirect to "/login"
    end
  end

  get '/anime/:id' do
    if logged_in?
      @anime = anime.find_by(params[:id])
      erb :'/anime/show_anime'
    else
      redirect to "/login"
    end
  end

  get '/anime/:id/edit' do
    if logged_in?
      @anime = current_user.anime.find_by(params[:id])
      erb :'/anime/edit_anime'
    else
      redirect to "/login"
    end
  end

  patch '/anime/:id' do
    if logged_in?
      @anime = current_user.anime.find_by(params[:id])
      if params[:content] != ""
        @anime.update(:content => params[:content])
        @anime.save
        redirect("/anime/#{@anime.id}")
      else
        redirect("/anime/#{@anime.id}/edit")
      end
    else
      redirect to "/login"
    end
  end

  delete '/anime/:id/delete' do
    if logged_in?
      @anime = current_user.anime.find_by(params[:id])
      @anime.delete
      redirect to "/anime"
    else
      redirect to "/login"
    end
  end



end
