class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
    @next_lesson = next_lesson_after(@lesson)
    module_names = Lesson.distinct.pluck(:module_name).sort_by { |module_name| module_name.to_s[/\d+/].to_i }
    current_module_index = module_names.index(@lesson.module_name)

    if current_module_index
      previous_module_name = module_names[current_module_index - 1] if current_module_index.positive?
      next_module_name = module_names[current_module_index + 1]

      @previous_module_lesson = first_lesson_in_module(previous_module_name) if previous_module_name
      @next_module_lesson = first_lesson_in_module(next_module_name) if next_module_name
    end
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

  private

  def first_lesson_in_module(module_name)
    Lesson.where(module_name: module_name).order(:lesson_number, :id).first
  end

  def next_lesson_after(lesson)
    ordered_lessons = Lesson.all.sort_by { |item| [ item.module_name.to_s[/\d+/].to_i, item.lesson_number, item.id ] }
    current_index = ordered_lessons.index(lesson)

    ordered_lessons[current_index + 1] if current_index
  end
end
