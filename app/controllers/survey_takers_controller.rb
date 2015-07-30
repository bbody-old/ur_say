require 'rest_client'
class SurveyTakersController < InheritedResources::Base
  def new
    @survey_taker = SurveyTaker.new
    #redirect_to root_url, notice: '#{name} - #{number}'
  end

  def create
    @survey_taker = SurveyTaker.new(survey_taker_params)
    @survey_taker.confirmed = 0

    resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=" + Rails.application.secrets.telstra_public_key + "&client_secret=" + Rails.application.secrets.telstra_private_key + "&grant_type=client_credentials&scope=SMS"
    token = JSON.parse(resp)["access_token"]
    header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
    puts "hello Brendon"
    name = params[:survey_taker][:name]
    number = params[:survey_taker][:number]
    puts name
    puts number

    result = JSON.parse(RestClient.post "https://staging.api.telstra.com/v1/sms/messages", {to: number, body: "#{name}, thank you for signing up. If you did not sign up, ignore this message. Otherwise reply with \"1\" to confirm"}.to_json, header)
    
    puts result
    puts result[:messageId]
    @survey_taker.message_id = result["messageId"]

    @survey_taker.save!

    respond_to do |format|
      if @survey_taker.update(survey_taker_params)
        format.html { redirect_to @survey_taker, notice: 'Successfully registered, awaiting verification.' }
        format.json { render :show, status: :ok, location: @survey_taker }
      else
        format.html { render :edit }
        format.json { render json: @survey_taker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @survey_taker.update(survey_taker_params)
        format.html { redirect_to root_url, notice: 'survey_taker was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_taker }
      else
        format.html { render :edit }
        format.json { render json: @survey_taker.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    if params[:number]
      @survey_takers = SurveyTaker.search(params[:number].to_s)
      if @survey_takers.first.confirmed == 0
        resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=" + Rails.application.secrets.telstra_public_key + "&client_secret=" + Rails.application.secrets.telstra_private_key + "&grant_type=client_credentials&scope=SMS"
        puts "https://staging.api.telstra.com/v1/oauth/token?client_id=" + Rails.application.secrets.telstra_public_key + "&client_secret=" + Rails.application.secrets.telstra_private_key + "&grant_type=client_credentials&scope=SMS"
        token = JSON.parse(resp)["access_token"]
        header =  {authorization: "Bearer " + token, "Content-Type" => "application/json", "Accept" => "application/json"}

        address = "https://api.telstra.com/v1/sms/messages/"+ @survey_takers.first.message_id + "/response"
        puts address
        response = RestClient.get(address, header)
        result = JSON.parse(response)[0]

        if result["content"][0] == "1"
          @survey_takers.first.confirmed = 1
          @survey_takers.first.save!
        end
      end
    else
      @survey_takers = nil
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @survey_taker.save!
    respond_to do |format|
      format.html { redirect_to survey_taker_url, notice: 'survey_taker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    @survey_taker = SurveyTaker.find_by_id(params[:id])
    if @survey_taker.nil? && @survey_taker.confirmed == 0
      resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=" + Rails.application.secrets.telstra_public_key + "&client_secret=" + Rails.application.secrets.telstra_private_key + "&grant_type=client_credentials&scope=SMS"
      token = JSON.parse(resp)["access_token"]
      header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
      puts ":::" + @survey_taker.message_id + ":::"
      response = RestClient.get("https://api.telstra.com/v1/sms/messages/"+ @survey_taker.message_id + "/response", header)
      @result = JSON.parse(response)[0]
      puts "Result:" + result
      puts "----------------------------------------------------------------------"
      if result["content"][0] == "1"
        @survey_taker.confirmed = 1
        @survey_taker.save!
      end
    end
  end

  private

    def survey_taker_params
      params.require(:survey_taker).permit(:name, :number, :message_id, :confirmed)
    end
end

