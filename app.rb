require 'sinatra'
require 'gyazo'
require 'unindent'

get '/' do
  'TwitPic to gyazo proxy endpoint: POST "/"'
end

# TwitPic API v2 compatible with YoruFukurou upload
# http://dev.twitpic.com/docs/2/upload/
post '/' do
  uploaded_image_path = params[:media][:tempfile].path

  client = Gyazo::Client.new
  url = client.upload(uploaded_image_path)

  <<-XML.unindent
    <?xml version="1.0" encoding="UTF-8"?>
    <image>
      <id>0</id>
      <text>dummy</text>
      <url>#{url}</url>
      <width>0</width>
      <height>0</height>
      <size>0</size>
      <type>png</type>
      <timestamp>Wed, 05 May 2010 16:11:15 +0000</timestamp>
      <user>
        <id>0</id>
        <screen_name>k0kubun</screen_name>
      </user>
    </image>
  XML
end
