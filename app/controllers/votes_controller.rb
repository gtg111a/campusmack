class VotesController < ApplicationController
  load_and_authorize_resource
  
  def destroy
    @vote.destroy
  end

end
