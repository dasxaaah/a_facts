class TutorialsController < ApplicationController
    before_action :authenticate_user!

  def index
    @tutorials = Tutorial.order(created_at: :desc)
    @lessons_by_module_and_number = Lesson.all.index_by { |lesson| [ lesson.module_name, lesson.lesson_number ] }
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end
end
