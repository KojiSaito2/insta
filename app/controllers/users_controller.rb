class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    if @user.posts.any?
      @post = Post.find(params[:id])
      #@comment = Comment.new
      #@comments = @post.comments.order(created_at: :desc)
      #@myfeeds = Post.where(user_id: [@post.id]).order(created_at: :desc)
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :username, :email, :website, :profile, :sex)
    end
  
end
