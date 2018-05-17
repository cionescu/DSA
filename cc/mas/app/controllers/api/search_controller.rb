class Api::SearchController < ApplicationController
  def index
    answers = MasSearcher.new(params.require(:q)).call
    if answers.any?
      render json: answers
    else
      render json: {}, status: :not_found
    end
  end
end
