require 'http'
require 'nokogiri'

module PureIterator
  class Base
    # @param config [Hash]
    # @option config [String] :host Pure host
    # @option config [String] :username Username of the Pure host account
    # @option config [String] :password Password of the Pure host account
    # @option config [String] :api_key API key of the Pure host account
    # @option config [Integer] :api_version Pure API version
    def initialize(config)
      http_client = HTTP::Client.new
      http_client = http_client.headers({ 'api-key' => config[:api_key] })
      http_client = http_client.basic_auth({user: config[:username], pass: config[:password]})
      @http_client = http_client
      @host = config[:host]
      @api_version = config[:api_version]
      accept :xml
    end

    # Set the response Accept type
    # @param accept [Symbol]
    def accept(accept)
      supported_accept = [:xml, :json]
      raise "Supported Accept values #{supported_accept}" unless supported_accept.include? accept
      @accept = accept
    end

    # Traverse a collection, doing something with each response (which may contain multiple records if size parameter used)
    # @param params [Hash] Pure POST parameters (except page and pageSize)
    # @return [String] 'done' when collection has been traversed
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

    # @return [String] Pure POST endpoint
    def post_endpoint
      # implement me
    end

    # @param response [HTTP::Response]
    def act(response)
      # implement me
    end
  end
end