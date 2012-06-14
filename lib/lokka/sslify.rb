module Lokka
  module Sslify
    def self.registered(app)
      app.configure :production do
        app.before do
          sslify = Option.sslify || false
          if sslify
            unless request.secure?
              url = request.url.sub('http', 'https')
              redirect url
            end
          end
        end
      end

      app.get '/admin/plugins/sslify' do
        haml :"plugin/lokka-sslify/views/index", :layout => :"admin/layout"
      end

      app.put '/admin/plugins/sslify' do
        Option.sslify = params['sslify']
        flash[:notice] = 'Updated'
        redirect '/admin/plugins/sslify'
      end
    end
  end
end
