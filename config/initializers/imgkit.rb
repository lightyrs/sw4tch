IMGKit.configure do |config|
  config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage-amd64').to_s if ENV['RACK_ENV'] == 'production'
  config.default_format = :png
end
