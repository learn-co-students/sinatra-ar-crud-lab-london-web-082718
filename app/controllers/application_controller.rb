
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  #NEW
  get '/posts/new' do
    erb :new
  end

  #Create
  post '/posts' do
    @post = Post.create(params)
    redirect "/posts"
  end

  #INDEX
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  #Show
  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end


  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update({name: params[:name], content: params[:content]})
    redirect "/posts/#{post.id}"
  end


  delete '/posts/:id/delete' do
    post = Post.find_by_id(params[:id])
    post.destroy
    redirect '/posts'
  end

end
