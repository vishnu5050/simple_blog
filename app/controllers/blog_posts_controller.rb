class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  before_action :correct_user, only: [:destroy ,:edit , :update,]

  respond_to :html

  def index
    if params[:search]
      @blog_posts = BlogPost.search(params[:search]).order("created_at DESC")
    else
      @blog_posts = BlogPost.order("created_at DESC")
    end
  end

  def show
    @blog_post = BlogPost.find(params[:id])
    respond_with(@blog_post)
  end

  def new
    @blog_post = current_user.blog_posts.new
    respond_with(@blog_post)
  end

  def edit
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params)
    @blog_post.user = current_user
    @blog_post.save
    respond_with(@blog_post)
  end

  def update
    @blog_post.update(blog_post_params)
    respond_with(@blog_post)
  end

  def destroy
    @blog_post.destroy
    respond_with(@blog_post)
  end

  private
    def correct_user
        @blog_post = current_user.blog_posts.find_by(id: params[:id])
        redirect_to root_url if @blog_post.nil?
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :post, :user_id)
    end
end
