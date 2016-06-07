class UsersController < ApplicationController
  #before_action :authenticate_user!
  #before_action :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

  def login
  end

  def show
    @user = User.find(params[:id])
    @posts = Campaign.joins(@User).where(:ownership => @user.id)
    @comments = Comment.joins(@User).where(:user_id => @user.id)
    @commentsTotal = @comments.count
  end
end
