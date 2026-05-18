class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
  end

  def toggle_favourite
    @lesson = Lesson.find(params[:id])

    favourite_lesson = FavouriteLesson.find_by(
      user_id: current_user.id,
      lesson_id: @lesson.id
    )

    if favourite_lesson
      favourite_lesson.destroy
    else
      FavouriteLesson.create(
        user_id: current_user.id,
        lesson_id: @lesson.id
      )
    end

    redirect_back fallback_location: lesson_path(@lesson)
  end
end
