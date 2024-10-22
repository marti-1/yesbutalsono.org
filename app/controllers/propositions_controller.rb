class PropositionsController < ApplicationController
  before_action :need_to_be_logged_in, only: [:upvote, :downvote]
  before_action :set_proposition, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authorize_author!, only: [:edit, :update, :destroy]

  def new
    redirect_to new_user_session_path if current_user.nil?
    @proposition = Proposition.new
  end

  def create
    @proposition = Proposition.new(proposition_params)
    @proposition.author = current_user
    if @proposition.save
      redirect_to @proposition
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @proposition.update(proposition_params)
      redirect_to @proposition
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @proposition.destroy
    redirect_to root_path, notice: "Proposition deleted"
  end


  def upvote
    @proposition.upvote_by(current_user)
    redirect_to @proposition
  end

  def downvote
    unless @proposition.author == current_user
      @proposition.downvote_by(current_user) 
    end
    redirect_to @proposition
  end

  private

  def set_proposition
    @proposition = Proposition.friendly.find(params[:id])
  end

  def need_to_be_logged_in
    unless user_signed_in?
      flash[:alert] = "You need to be logged to perform this action"
      redirect_back_or_to new_user_session_path
    end
  end

  def proposition_params
    params.require(:proposition).permit(:body, :description)
  end

  def authorize_author!
    unless @proposition.author == current_user
      redirect_to new_user_session_path, alert: "You must be logged in!"
    end
  end
end
