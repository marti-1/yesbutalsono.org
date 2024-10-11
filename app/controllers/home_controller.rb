class HomeController < ApplicationController
  def index
    @propositions = Proposition.order('created_at DESC').limit(30)
  end
end
