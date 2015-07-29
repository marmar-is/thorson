class AddQuotePdfToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :quote_pdf, :string
  end
end
