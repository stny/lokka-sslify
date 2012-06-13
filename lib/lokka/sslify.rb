module Lokka
  module SSLify
    def self.registered(app)
      app.configure :production do
        app.before do
          unless request.secure?
            url = request.url.sub('http', 'https')
            redirect url
          end
        end
      end
    end
  end
end
