class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to profile_path(tab: "works", view: (@project.status == "draft" ? "drafts" : nil))
    else
      redirect_to profile_path(tab: "works"), alert: "Не удалось сохранить проект"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :kind, :media)
  end
end
