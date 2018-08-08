
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.new
      @post.name = params[:name]
      @post.content = params[:content]
      @post.save

    redirect to '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id].to_i)
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id/edit' do
    @post = Post.find(params[:id].to_i)
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect to "/posts/#{params[:id]}"
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id].to_i)
    @post.destroy
    erb :delete
  end


#final end
end
