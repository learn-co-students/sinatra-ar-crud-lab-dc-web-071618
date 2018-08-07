
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(params)
    redirect to '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    name = params[:name]
    content = params[:content]
    @post.update(name: name, content: content)
    erb :show
  end

  delete '/posts/:id/delete' do
    post = Post.find(params[:id])
    post.destroy
    erb :delete
  end

end
