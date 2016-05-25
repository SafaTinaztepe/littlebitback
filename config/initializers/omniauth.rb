Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "841186759272364", "77ce5055aea43596d640dc844d586e84"
  provider :google_oauth2, "1098169020843-nbvrem706pb1q7sustg675faa017vs1e.apps.googleusercontent.com", "H3NZINs_IAQ1jBcYGHVz9MUj"
  OmniAuth.config.full_host = Rails.env.production? ? 'http://littlebitback.herokuapp.com' : 'http://localhost:3000'
end
