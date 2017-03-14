class WebhooksController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    answers = data["form_response"]["answers"]

    languages = answers.find { |x| x["field"]["id"] == "41986482"}
    unless languages["choices"]["other"].to_s.strip.empty?
      languages["choices"]["labels"].push(languages["choices"]["other"])
    end
    language_list = languages["choices"]["labels"]


    email_address = answers.find { |x| x["field"]["id"] == "41986489"}
    email = email_address["email"]
    # data.map

    first = answers.find { |x| x["field"]["id"] == "41986475"}
    first_name = first["text"]
    
    last = answers.find { |x| x["field"]["id"] == "41986476"}
    last_name = last["text"]

    addr = answers.find { |x| x["field"]["id"] == "41986477"}
    address = addr["text"]
    address_params = "q=" + CGI.escape(address)
    params += ""
    google_maps_link = URI.parse("http://maps.google.com/maps/geo?#{params}")
    params2 = params + "|&amp;zoom=14&amp;size=570x200&amp;sensor=false"
    google_maps_embed = URI.parse("http://maps.google.com/maps/geo?#{params2}")

    city_name = answers.find { |x| x["field"]["id"] == "41986478"}
    city = city_name["text"]

    state = "FL"

    zip = answers.find { |x| x["field"]["id"] == "41986488"}
    zip_code = zip["choice"]["label"]

    mobile_phone = answers.find { |x| x["field"]["id"] == "41986479"}
    phone_number = mobile_phone["text"]

    voted = answers.find { |x| x["field"]["id"] == "41986490"}
    did_you_vote = voted["boolean"].to_s.strip.empty?

    called_311 = answers.find { |x| x["field"]["id"] == "41986491"}
    did_you_call_311 = called_311["boolean"].to_s

    access_primary = answers.find { |x| x["field"]["id"] == "41986484"}
    unless access_primary["choice"]["other"].to_s.strip.empty?
      access_primary["choice"]["label"].push(access_primary["choice"]["other"])
    end
    primary_internet_access = access_primary["choice"]["label"].to_s
    
    access_secondary = answers.find { |x| x["field"]["id"] == "41986485"}
    unless access_secondary["choice"]["other"].to_s.strip.empty?
      access_secondary["choice"]["label"].push(access_secondary["choice"]["other"])
    end
    secondary_internet_access = access_secondary["choice"]["label"].to_s

    access_device = answers.find { |x| x["field"]["id"] == "41986486"}
    primary_internet_device = access_primary["choice"]["label"].to_s

    make_model = answers.find { |x| x["field"]["id"] == "41986480"}
    primary_device_make_model = make_model["text"]

    referral_cutgroup = answers.find { |x| x["field"]["id"] == "41986481"}
    referral = referral_cutgroup["text"]

    participation_method = answers.find { |x| x["field"]["id"] == "41986483"}
    how_to_participate = participation_method["choices"]["labels"].to_s

    notification_method = answers.find { |x| x["field"]["id"] == "41986487"}
    how_to_notify = notification_method["choices"]["labels"].to_s


    @Person = Person.create(:first_name => first_name, :last_name => last_name, :email_address => email, :address_1 => address, :city => city, :state => state, :postal_code => zip_code, :phone_number => phone_number, :called_311 => did_you_call_311, :voted => did_you_vote, :primary_connection_id => primary_internet_access, :secondary_connection_id => secondary_internet_access, :primary_device_id => primary_internet_device, :primary_device_description => primary_device_make_model, :referral => referral, :participation_type => how_to_participate, :preferred_contact_method => how_to_notify)
      puts @Person

    render nothing: true
  end
end