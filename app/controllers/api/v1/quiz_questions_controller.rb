class Api::V1::QuizQuestionsController < ApplicationController
  def index
    render json: QuizQuestion.all
  end
end
