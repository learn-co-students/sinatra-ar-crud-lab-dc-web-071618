
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts' do
    @posts = Post.all

    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id' do
    id = params[:id]
    @post = Post.find(id)

    erb :show
  end

  get '/posts/:id/edit' do
    id = params[:id]
    @post = Post.find(id)

    erb :edit
  end

  patch '/posts/:id' do
    id = params[:id]
    @post = Post.find(id)
    name = params[:name]
    content = params[:content]
    @post.update(name: name, content: content)
    redirect "/posts/#{@post.id}"
  end

  post '/posts' do
    Post.create(params)

    @posts = Post.all

    erb :index
  end

  delete '/posts/:id/delete' do
    id = params[:id]
    @post = Post.find(id)
    @post.destroy
    erb :delete
  end
end
