class CreateGlossaryTerms < ActiveRecord::Migration[8.1]
  def change
    create_table :glossary_terms do |t|
      t.string :term
      t.text :definition
      t.string :category

      t.timestamps
    end
  end
end
