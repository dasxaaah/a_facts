class Api::V1::GlossaryTermsController < ApplicationController
  def index
    @terms = GlossaryTerm.order(:term)
    render json: @terms
  end
end
