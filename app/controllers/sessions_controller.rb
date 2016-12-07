   class SessionsController < Devise::SessionsController
      respond_to :json

      # GET /resource/sign_in
      def new
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        if request.format.json?
          markup = render_to_string :template => "devise/sessions/popup_login", :layout => false
          render :json => { :data => markup }.to_json
        else
          respond_with(resource, serialize_options(resource))
        end
      end

      # POST /resource/sign_in
      def create
      	response.headers['X-CSRF-Token'] = form_authenticity_token
        if request.format.json?
          self.resource = warden.authenticate(auth_options)
          if resource.nil?
            return render json: {status: 'error', message: 'invalid username or password'}
          end
          sign_in(resource_name, resource)
          render json: {status: 'success', message: '¡User authenticated!'}
        else
          self.resource = warden.authenticate!(auth_options)
          set_flash_message(:notice, :signed_in)
          sign_in(resource_name, resource)
          yield resource if block_given?
          respond_with resource, location: after_sign_in_path_for(resource)
        end
      end

    end