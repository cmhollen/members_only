class PostsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create]
    
    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.name
        if @post.save
            redirect_to posts_url
        else
            render 'new'
        end
    end

    private

    def logged_in_user
        unless logged_in?
            redirect_to login_url
        end
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end
end
