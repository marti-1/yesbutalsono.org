class PropositionsController < ApplicationController
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
    @proposition = Proposition.friendly.find(params[:id])
  end

  private

  def proposition_params
    params.require(:proposition).permit(:body)
  end
end
