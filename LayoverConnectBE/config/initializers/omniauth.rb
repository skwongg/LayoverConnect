OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "296306267160423", "f25747af83c5dd5862ce821c2273f048"
end
