class ArgumentsController < ApplicationController
  before_action :set_proposition, only: [:edit, :update, :new, :create, :destroy]
  before_action :set_argument, only: [:edit, :update, :destroy]
  before_action :authorize_author!, only: [:edit, :update, :destroy]

  def new
    @argument = @proposition.arguments.build
    # set @argument.side using side parameter that can be either "yes" or "no"
    @argument.side = params[:side] == "yes" ? true : false
  end

  def create
    @argument = @proposition.arguments.build(argument_params)
    @argument.author = current_user
    if @argument.save
      redirect_to @proposition, notice: "Argument created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @argument.update(argument_params)
      redirect_to @proposition, notice: "Argument updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @argument.destroy
    redirect_to @proposition, notice: "Argument deleted"
  end

  private

  def argument_params
    params.require(:argument).permit(:body, :side)
  end 

  def set_proposition
    @proposition = Proposition.friendly.find(params[:proposition_id])
  end

  def set_argument
    @argument = @proposition.arguments.find(params[:id])
  end

  def authorize_author!
    unless @argument.author == current_user
      redirect_to new_user_session_path, alert: "You must be logged in!"
    end
  end

end
