class GlossaryTermsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_terms

  def index
    module_number = params[:module].to_i
    module_number = 1 unless module_number.between?(1, 6)
    module_terms = @term_modules[module_number - 1] || []

    if module_terms.any?
      redirect_to glossary_term_path(module_terms.first)
    else
      @term = nil
      @module_number = module_number
      @module_terms = []
      render :show
    end
  end

  def show
    @term = GlossaryTerm.find(params[:id])
    @module_number = @term_modules.index { |terms| terms.include?(@term) }.to_i + 1
    @module_terms = @term_modules[@module_number - 1] || []
    current_index = @module_terms.index(@term)
    @term_position = current_index.to_i + 1

    if current_index
      @previous_term = @module_terms[current_index - 1] if current_index.positive?
      @next_term = @module_terms[current_index + 1]
    end
  end

  private

  def set_terms
    @terms = GlossaryTerm.order(:term).to_a
    @term_modules = build_term_modules(@terms)
  end

  def build_term_modules(terms)
    first_module_terms = terms.first(11)
    remaining_terms = terms.drop(11)
    base_size, extra_terms = remaining_terms.size.divmod(5)
    modules = [ first_module_terms ]
    offset = 0

    5.times do |index|
      size = base_size + (index < extra_terms ? 1 : 0)
      modules << remaining_terms.slice(offset, size).to_a
      offset += size
    end

    modules
  end
end
