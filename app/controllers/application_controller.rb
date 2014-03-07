class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_headers

  private

  def set_headers
    headers['Access-Control-Allow-Origin'] = 'http://rubyonrailstutor.github.io'
    headers['Access-Control-Allow-Methods'] = 'POST'
  end
end
