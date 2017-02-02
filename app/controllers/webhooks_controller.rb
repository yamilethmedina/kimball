class WebhooksController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:typeform])

    render nothing: true
  end
end