require 'spec_helper'

if skeleton_rails?
  describe Skeleton::DocumentationController, '#swagger' do
    before do
      @routes = Skeleton::Engine.routes
      run_request
    end
    
    describe 'the http status' do
      it 'must equal 200' do
        assert_equal(200, @response.status)
      end
    end
    
    describe 'the http headers' do
      describe 'Allow' do
        it 'must equal "GET,HEAD"' do
          assert_equal('GET,HEAD', @response.headers['Allow'])
        end
      end
    end
    
    describe 'the http body' do
      before { @body = JSON.parse(@response.body) }
      it 'contains the GET options' do
        refute_nil(@body['data']['get'], 'expected get documentation to be present')
      end
    end

    def run_request
      options(:index_options, format: 'json')
    end
  end
end
