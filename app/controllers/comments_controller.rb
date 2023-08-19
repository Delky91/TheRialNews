class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /comments or /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render 'posts/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if user_can_modify_comment?
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: 'You cant edit this comment'
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if user_can_modify_comment?
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: 'Cant destroy comment that arent your'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :content)
  end

  def user_can_modify_comment?
    current_user.admin? || current_user.id == @comment.user.id
  end
end
