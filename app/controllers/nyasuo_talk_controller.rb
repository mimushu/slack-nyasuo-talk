class SampleController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def nyasuo_talk
    # person_speech = params[:text]
    person_speech = params[:text]
    person_speech.slice!("にゃすお！")

#recruit api

#     value = `curl -X POST https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk \
# -F "apikey=ljwzlxEfZoYpKWzQfVQxOBZPpo1DquR8" \
# -F "query=#{person_speech}"`
#
#   nyasuo_response = "#{eval(value)[:results][0][:reply]}".to_s

#simsim api
  response = Net::HTTP.get_response(URI.escape("http://sandbox.api.simsimi.com/request.p?key=6aea4fbd-7813-496f-9526-c1b0b5cfc9f2&lc=ja&text=おっぱい大好き？"))
  # value = `curl -X GET http://sandbox.api.simsimi.com/request.p\?key=6aea4fbd-7813-496f-9526-c1b0b5cfc9f2&lc=ja&text=おはよう" `
  nyasuo_response = response[:response]


#post to slack
  uri  = URI.parse('https://hooks.slack.com/services/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')
  # params = { text: "hogehoge" }
  params = { text: nyasuo_response }
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    http.request(request)
  end
  return nyasuo_responce

  end
end
