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
    # puts data["form_response"]["answers"][0]["field"]["id"] 
    puts data["form_response"]["answers"][0] # randomized field
    @answers = data["form_response"]["answers"]
    # puts answers
    # answers.each do |item|
    #   puts item 
    # end

    # fields = answers.find { |x| x["field"]["id"] == "41986482"}

    languages = answers.find { |x| x["field"]["id"] == "41986482"}
    unless languages["choices"]["other"].to_s.strip.empty?
      languages["choices"]["labels"].push(languages["choices"]["other"])
    end
    puts language_list = languages["choices"]["labels"]


    email_address = answers.find { |x| x["field"]["id"] == "41986489"}
    puts email = email_address["email"]
    # data.map

    first = answers.find { |x| x["field"]["id"] == "41986475"}
    puts first_name = first["text"]
    
    last = answers.find { |x| x["field"]["id"] == "41986476"}
    puts last_name = last["text"]

    addr = answers.find { |x| x["field"]["id"] == "41986477"}
    puts address = addr["text"]

    city_name = answers.find { |x| x["field"]["id"] == "41986478"}
    puts city = city_name["text"]

    state = "FL"

    zip = answers.find { |x| x["field"]["id"] == "41986488"}
    puts zip_code = zip["choice"]["label"]

    mobile_phone = answers.find { |x| x["field"]["id"] == "41986479"}
    puts phone_number = mobile_phone["text"]



    # hash_of_params = JSON.load(request.params["form_response"]).to_hash
    # puts hash_of_params

    # data["form_response"]["answers"]["field"].each do |id|
    #   print id
    # end
    # field_ids = JSON.parse(data.form_response.answers)['field'].map { |p| p['id'] }
    # puts field_ids

    # Person.create(:first_name => data.webhook.form_response.answers.map(@:text))

    @Person = Person.create(:first_name => first_name, )

    render nothing: true
  end
end