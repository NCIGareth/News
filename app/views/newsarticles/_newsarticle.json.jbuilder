# frozen_string_literal: true

json.extract! newsarticle, :id, :source, :author, :title, :text, :imglink, :articlelink, :created_at, :updated_at
json.url newsarticle_url(newsarticle, format: :json)
