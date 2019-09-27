require 'http'
require 'nokogiri'

module PureIterator
  class Base
    def initialize(config)
      http_client = HTTP::Client.new
      http_client = http_client.headers({ 'api-key' => config[:api_key] })
      http_client = http_client.basic_auth({user: config[:username], pass: config[:password]})
      @http_client = http_client
      @host = config[:host]
      @api_version = config[:api_version]
      accept :xml
    end

    def accept(accept)
      supported_accept = [:xml, :json]
      raise "Supported Accept values #{supported_accept}" unless supported_accept.include? accept
      @accept = accept
    end

    def iterate(params = {})
      @http_client = @http_client.headers({ 'Accept' => "application/xml" })
      default_count_params = {size: 0}
      options = params.dup
      options.delete :page
      options.delete :pageSize
      response = @http_client.post url, json: default_count_params.merge(options)
      if response.code === 200
        record_count = count response
      else
        raise response
      end
      @http_client = @http_client.headers({ 'Accept' => "application/#{@accept}" })
      default_query_params = {size: 1, offset: 0}
      query_params = default_query_params.merge(options)
      size = query_params[:size]
      offset = query_params[:offset]
      while offset < record_count
        response = @http_client.post url, json: {size: size, offset: offset}
        act response
        offset += size
      end
      'done'
    end

    private

    def url
      File.join 'https://', @host, 'ws', 'api', @api_version.to_s, post_endpoint
    end

    def count(xml)
      doc = Nokogiri::XML xml
      doc.remove_namespaces!
      doc.xpath('/result/count').text.to_i
    end

    # implement me
    def post_endpoint
    end

    # implement me
    def act(response)
    end
  end
end