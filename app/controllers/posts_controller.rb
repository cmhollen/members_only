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
        if @post.save
            @author = @post.user_id
            redirect_to 'new'
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
