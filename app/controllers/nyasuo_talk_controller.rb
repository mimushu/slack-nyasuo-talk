class SampleController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def nyasuo_talk
    # person_speech = params[:text]
    person_speech = params[:text]
    person_speech.slice!("にゃすお！")

    value = `curl -X POST https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk \
-F "apikey=ljwzlxEfZoYpKWzQfVQxOBZPpo1DquR8" \
-F "query=#{person_speech}"`

  nyasuo_responce = "#{eval(value)[:results][0][:reply]}".to_s
  #  puts "paramsの内容はこちらです#{params[:attachments][0][:text]}"
   # コメント

  #  nyasuo_responce = "今日もかわいいね"

  # input_text = nyasuo_responce.to_s unless nyasuo_responce.kind_of?(String)

  uri  = URI.parse('https://hooks.slack.com/services/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')
  # params = { text: "hogehoge" }
  params = { text: person_speech }
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    http.request(request)
  end



  uri  = URI.parse('https://hooks.slack.com/services/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')
  # params = { text: "hogehoge" }
  params = { text: nyasuo_responce }
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
