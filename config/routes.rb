Skeleton::Engine.routes.draw do
  get 'api-docs', to: 'documentation#swagger', as: 'api_documentation'
end
