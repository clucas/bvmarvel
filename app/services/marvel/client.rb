class Marvel::Client
  include HTTParty
  base_uri Marvel::CONFIG[:config][:base_url]

  attr_reader :config

  def initialize(options = {})
    @public_key = options[:public_key]
    @private_key = options[:private_key]
  end

  def get(path, options = {})
    puts "SERVICE CALL"
    p path
    pp all_params(options)
    parse_response(self.class.get(path, query: all_params(options)))
  end

  private

  def parse_response(http_response)
    response = Marvel::Response.new
    response.parse(http_response)
    response
  end

  def all_params(option_params)
    option_params.merge({ apikey: @public_key, ts: ts, hash: key_hash })
  end

  def key_hash
    Digest::MD5.hexdigest("#{ts}#{@private_key}#{@public_key}")
  end

  def ts
    Time.now.to_i
  end

  def url

  end
end