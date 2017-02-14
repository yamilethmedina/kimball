class WebhooksController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    # put in database (with model? in something?)

    puts data
    field_ids = JSON.parse(answers)['field'].map { |p| p['id'] }
    puts field_ids

    # Person.create(:first_name => data.webhook.form_response.answers.map(@:text))

    # @Person = Person.create(:first_name => params[:])

    render nothing: true
  end
end