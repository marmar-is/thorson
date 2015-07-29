class Quote < ActiveRecord::Base
  # Associations
  belongs_to :rating

  # Enumerations
  enum status: [:created, :issued, :accepted, :declined]
    # created      -- underwriter created the quote/actions have not yet been taken
    # issued       -- underwriter's decision to issue the quote to the broker
    # accepted     -- broker's decision to accepted the quote
    # declined     -- broker's decision to declined the quote

  # Accessors
  attr_accessor :additions

  # Carrierwave Upload QuotePdf
  mount_uploader :quote_pdf, QuoteUploader
end
