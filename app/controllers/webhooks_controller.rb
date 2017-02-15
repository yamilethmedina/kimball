class WebhooksController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!

  def receive
    if request.headers['Content-Type'] == 'application/json'
      @data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      @data = params.as_json
    end

    # put in database (with model? in something?)

    puts @data

    @data['form_response'[0]['answers'][0]['field'][0].each do |id|
      print id[0]
    end
    # field_ids = JSON.parse(data.form_response.answers)['field'].map { |p| p['id'] }
    # puts field_ids

    # Person.create(:first_name => data.webhook.form_response.answers.map(@:text))

    # @Person = Person.create(:first_name => params[:])

    render nothing: true
  end
end