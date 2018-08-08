
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/posts/new' do #load new form
    erb :new
  end

  get '/posts' do #load all posts from index.erb
    @posts = Post.all
    erb :index
  end

  post '/posts' do #create new post
    @post = Post.new(params)
    @post.save
    redirect '/posts'
  end

  get '/posts/:id' do #load show.erb
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do #load edit.erb form
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do #update/edit post
    @post = Post.find(params[:id])
    name = params[:name]
    content = params[:content]
    @post.update(name: name, content: content)
    erb :show #redirects to 'posts/:id'
  end

  delete '/posts/:id/delete' do #delete post
      @post = Post.find(params[:id])
      @post.destroy
      erb :deleted
      redirect "/posts"
  end

end
