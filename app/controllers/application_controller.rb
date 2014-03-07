class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_headers

  private

  def set_headers
    headers['Access-Control-Allow-Origin'] = 'http://rubyonrailstutor.github.io'
    headers['Access-Control-Allow-Methods'] = 'POST'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
    headers['Access-Control-Expose-Headers'] = 'ETag'
  end
end
