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
    puts data.is_a?(Hash) #it is not an array, should be a hash



    # puts data.first["form_response"]["answers"]["field"]
    puts data.first["form_response"]["answers"]["field"].to_i

    # hash_of_params = JSON.load(request.params["form_response"]).to_hash
    # puts hash_of_params

    # data["form_response"]["answers"]["field"].each do |id|
    #   print id
    # end
    # field_ids = JSON.parse(data.form_response.answers)['field'].map { |p| p['id'] }
    # puts field_ids

    # Person.create(:first_name => data.webhook.form_response.answers.map(@:text))

    # @Person = Person.create(:first_name => params[:])

    render nothing: true
  end
end