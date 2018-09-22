
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # enable root server endpoint
    get '/' do
    end

# The index action should render the erb view index.erb, which shows a list of all of the posts.
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  # render new post form
  # create a route in your controller, get '/posts/new', that renders the new.erb view.
  get '/posts/new' do
    erb :new
  end

# create new post
  post '/posts' do
    Post.create(params)
    @posts = Post.all
    erb :show
  end

# This action should use Active Record to grab the post with the id that is in the params and set it equal to @post. Then, it should render the show.erb view page. That view should use erb to render the @post's title and content.
  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :show
  end

# render post of concern
# Create a controller action, get '/posts/:id/edit', that renders the view, edit.erb. This view should contain a form to update a specific blog post and POSTs to a controller action, patch '/posts/:id'.
  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

# edit post
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(name: params[:name], content: params[:content])
    redirect "/posts/#{params[:id]}"
  end

# update a post
 put '/posts/:id' do
   post = Post.get(params[:id])
   post.name = params[:name]
   post.content = params[:content]
   post.save
   redirect to '/'
 end

# delete a post

  delete '/posts/:id' do
    post = Post.find(params[:id])
    post.destroy
    erb :delete
    end

end
