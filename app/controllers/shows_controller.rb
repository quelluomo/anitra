class ShowsController < ApplicationController

  get '/shows' do
    if logged_in?
      @show = Show.all
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

 post '/show' do
   if logged_in?
     @show = current_user.show.new(:title => params[:title], :score => params[:score])
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
      @show = Show.find_by(params[:id])
      erb :'/shows/show_show'
    else
      redirect to "/login"
    end
  end

  get '/shows/:id/edit' do
    if logged_in?
      @show = current_user.show.find_by(params[:id])
      erb :'/shows/edit_show'
    else
      redirect to "/login"
    end
  end

  patch '/shows/:id' do
    if logged_in?
      @show = current_user.show.find_by(params[:id])
      if params[:title] != ""
        @show.update(:title => params[:title], :score => params[:score])
        @show.save
        redirect("/shows/#{@show.id}")
      else
        redirect("/shows/#{@shows.id}/edit")
      end
    else
      redirect to "/login"
    end
  end

  delete '/shows/:id/delete' do
    if logged_in?
      @show = current_user.show.find_by(params[:id])
      @show.delete
      redirect to "/shows"
    else
      redirect to "/login"
    end
  end

end
