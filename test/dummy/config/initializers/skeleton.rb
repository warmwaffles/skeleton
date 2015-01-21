Skeleton.configure do |config|
  config.define do |structure|
    structure.host = 'localhost'
    structure.base_path = '/skeleton'

    structure.schemes = %w(http https)
    structure.consumes = %(application/json)
    structure.produces = %(application/json text/html)
  end

  config.info do |info|
    info.version = '1'
    info.title = 'Dummy Rails Test Project'
    info.description = 'Dummy project to test the Skeleton Gem\'s engine on'
  end
end
