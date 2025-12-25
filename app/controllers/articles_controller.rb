# class ArticlesController < ApplicationController
#   def index
#   end

#   def show
#   end
# end

class ArticlesController < ApplicationController
  def index
    @articles = [
      { slug: "article1", title: "Первая статья" },
      { slug: "article2", title: "Вторая статья" }
    ]
  end

  def show
    @article = params[:id]
  end
end

