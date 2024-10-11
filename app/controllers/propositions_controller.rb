class PropositionsController < ApplicationController
  before_action :need_to_be_logged_in, only: [:upvote, :downvote]
  before_action :set_proposition, only: [:show, :upvote, :downvote]

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

  def upvote
    @proposition.upvote_by(current_user)
    redirect_to @proposition
  end

  def downvote
    @proposition.downvote_by(current_user)
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
    params.require(:proposition).permit(:body)
  end
end
