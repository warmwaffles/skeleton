module Fixtures
  def self.read(file)
    path = File.expand_path(File.join('..', '..', 'fixtures', file), __FILE__)
    File.read(path)
  end
end
