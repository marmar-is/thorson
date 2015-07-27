class Quote < ActiveRecord::Base
  # Associations
  belongs_to :rating

  # Enumerations
  enum status: [:issued, :accepted, :declined]
    # issued       -- actions have not yet been taken
    # accepted     -- broker's decision to accepted the quote
    # declined     -- broker's decision to declined the quote

end
