require 'sinatra/base'
require 'sinatra/namespace'
require 'virginia/document_cache'

class DocumentServer < Sinatra::Base
  register Sinatra::Namespace

  get '/documents/:id' do
    begin
      document = Virginia::DocumentCache.fetch params[:id]
      headers['Content-Type'] = document.content_type
      document.body
    rescue Virginia::DocumentCache::NotFound
      raise Sinatra::NotFound
    end
  end
end
