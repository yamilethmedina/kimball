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
    answers = data["form_response"]["answers"]
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

    voted = answers.find { |x| x["field"]["id"] == "41986490"}
    puts did_you_vote = voted["boolean"].to_s.strip.empty?

    called_311 = answers.find { |x| x["field"]["id"] == "41986491"}
    puts did_you_call_311 = called_311["boolean"].to_s

    access_primary = answers.find { |x| x["field"]["id"] == "41986484"}
    unless access_primary["choice"]["other"].to_s.strip.empty?
      access_primary["choice"]["label"].push(access_primary["choice"]["other"])
    end
    puts primary_internet_access = access_primary["choice"]["label"].to_s
    
    access_secondary = answers.find { |x| x["field"]["id"] == "41986485"}
    unless access_secondary["choice"]["other"].to_s.strip.empty?
      access_secondary["choice"]["label"].push(access_secondary["choice"]["other"])
    end
    puts secondary_internet_access = access_secondary["choice"]["label"].to_s

    access_device = answers.find { |x| x["field"]["id"] == "41986486"}
    puts primary_internet_device = access_primary["choice"]["label"].to_s

    make_model = answers.find { |x| x["field"]["id"] == "41986480"}
    puts primary_device_make_model = make_model["text"]

    referral_cutgroup = answers.find { |x| x["field"]["id"] == "41986481"}
    puts referral = referral_cutgroup["text"]

    participation_method = answers.find { |x| x["field"]["id"] == "41986483"}
    puts how_to_participate = participation_method["choices"]["labels"].to_s

    notification_method = answers.find { |x| x["field"]["id"] == "41986487"}
    puts how_to_notify = notification_method["choices"]["labels"].to_s

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