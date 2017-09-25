require 'roda'

class RecipeerApp < Roda
  plugin :default_headers,
    'Content-Type'=>'application/json',
    'Content-Security-Policy'=>"default-src 'self'",
    'Strict-Transport-Security'=>'max-age=16070400;',
    'X-Frame-Options'=>'deny',
    'X-Content-Type-Options'=>'nosniff',
    'X-XSS-Protection'=>'1; mode=block'

  # probably just require password as header
  route do |r|
    r.on "ingredients" do
      "hello"
      # authenticate
      # return list of recipe ingredients
    end
  end
end
