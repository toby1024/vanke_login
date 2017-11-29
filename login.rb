class Login
  require "net/https"  
  require "uri"  
  require 'json'
  require "base64"

  phone = Base64.strict_encode64(ARGV[0])
  password = Base64.strict_encode64(ARGV[1])
  # servie_id = ARGV[2]
  servie_id = 'a3730fc998a5d2558d8610dace40444c|1511946098|1511945951'
    
  uri = URI.parse("https://union.vanke.com/api/Member/Login")
  get_point_url = URI.parse("https://union.vanke.com/api/Points/GetMyPoints")
  while(true)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri,'Content-Type' => 'application/json')
      request.body = { body: { AccountName: phone, 
                              AgentId:"", 
                              AuthCode:"",
                              LoginType:1, 
                              Password: password, 
                              ThirdPartyUserId:"",Token:""
                              },
                      header:{ version:"",
                                clientOSType:"android",
                                accessToken:"",
                                refreshToken:"",
                                sign:""
                              }
                      }.to_json
      response = http.request(request)
      response_data = JSON.parse(response.body)
      access_token = response_data["body"]["access_token"]
      refresh_token = response_data["body"]["refresh_token"]
      p access_token
      p refresh_token

      # get my points
      Net::HTTP.start(get_point_url.host, get_point_url.port, use_ssl: true) do |http2|
        request2 = Net::HTTP::Post.new(get_point_url, 'Content-Type' => 'application/json')
        request2.body = { body: 263104,
                        header: { version: "",
                                  clientOSType: "android",
                                  accessToken: access_token,
                                  refreshToken: refresh_token,
                                  sign: "" }
                       }.to_json
        response = http2.request(request2)
        response_data = JSON.parse(response.body)
        p response_data
      end
    end
    sleep(10*60*60)
  end
end
