class Api::V1::QuizzesController < ApplicationController
  def index
    quizzes = Quiz.all

    render json: quizzes.as_json(
      only: [ :id, :title, :category, :description ],
      methods: []
    )
  end

  def show
    quiz = Quiz.includes(:quiz_questions).find(params[:id])

    render json: quiz.as_json(
      only: [ :id, :title, :category, :description ],
      include: {
        quiz_questions: {
          only: [ :id, :question, :option_a, :option_b, :option_c, :option_d, :correct_answer ]
        }
      }
    )
  end
end
