class StaticsController < ApplicationController
  layout false, only: [ :portal ]

  def index
  end

  def portal
  end

  private
    def resolve_layout
      case action_name
      when "portal"
        nil
      else
        "application"
      end
    end
end
