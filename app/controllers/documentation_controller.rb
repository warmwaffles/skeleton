module Skeleton
  class DocumentationController < ApplicationController
    def swagger
      hash = ::Skeleton.config.structure.to_swagger_hash
      
      hash[:host] = request.host
      respond_to do |format|
        format.json { render(json: hash, status: 200) }
      end
    end
  end
end
