# frozen_string_literal: true

json.array! @newsarticles, partial: 'newsarticles/newsarticle', as: :newsarticle
