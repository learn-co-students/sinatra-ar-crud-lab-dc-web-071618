
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    @post = Post.create(name: params[:name], content: params[:content])
    redirect '/posts'
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
    redirect "/posts/#{@post.id}"
  end


  get '/posts/:id' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

  delete '/posts/:id/delete' do
    post = Post.find(params[:id])
    post.destroy
    redirect "/posts"
  end
end
