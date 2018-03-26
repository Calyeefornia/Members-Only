class PostsController < ApplicationController
	before_action :only_members, only: [:new, :create]

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.author = current_user.name
		if @post.save
			flash[:success] = "Post saved"
			redirect_to posts_path
		else
			flash[:warning] = "Can't save post"
			render 'new'
		end
	end
	def index
		@posts = Post.order(id: :desc)
	end
	private
	def only_members
		unless logged_in?
			flash[:danger] = 'You must be a member and logged in to do that'
			redirect_to login_path
		end
	end
	def post_params
		params.require(:post).permit(:title, :body, :author)
	end

end
