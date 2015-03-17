class BlogPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  

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
    @blog_post = BlogPost.new
    respond_with(@blog_post)
  end

  def edit
  end

  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    if @blog_post.save
      redirect_to root_url
      flash[:success] = "Blog Post Created successfully"
    else
      render 'new'
    end
    #respond_with(@blog_post)
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
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end
    

    def blog_post_params
      params.require(:blog_post).permit(:title, :post, :user_id)
    end
end
