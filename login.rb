class Login
  require "net/https"  
  require "uri"  
  require 'json'
  require "base64"

  phone = Base64.encode64(ARGV[0])
  password = Base64.encode64(ARGV[1])
    
  uri = URI.parse("https://union.vanke.com/api/Member/Login")
  
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Post.new(uri,'Content-Type' => 'application/json')
    request.body = {body:{AccountName: phone,AgentId:"",AuthCode:"",LoginType:1,Password: password,ThirdPartyUserId:"",Token:""},header:{version:"",clientOSType:"android",accessToken:"",refreshToken:"",sign:""}}.to_json
    request.set_form_data(AccountName: 'MTM2MzQxNzE0MDQ=', Password: 'aGFuaGFuMTIzNA==', LoginType: 1, AgentId:'',AuthCode:'',Token:'')
    response = http.request request # Net::HTTPResponse object
    p response.body
  end
end
