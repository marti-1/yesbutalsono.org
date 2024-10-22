class ArgumentsController < ApplicationController

  def new
    @proposition = Proposition.friendly.find(params[:proposition_id])
    @argument = @proposition.arguments.build
    # set @argument.side using side parameter that can be either "yes" or "no"
    @argument.side = params[:side] == "yes" ? true : false
  end

  def create
    @proposition = Proposition.friendly.find(params[:proposition_id])
    @argument = @proposition.arguments.build(argument_params)
    @argument.author = current_user
    if @argument.save
      redirect_to @proposition, notice: "Argument created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def argument_params
    params.require(:argument).permit(:body, :side)
  end 

end
