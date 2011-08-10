class VotesController < ApplicationController
  
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
end
