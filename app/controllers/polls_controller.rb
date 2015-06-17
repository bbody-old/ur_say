require 'rest_client'
class PollsController < ApplicationController


  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  def history
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=g29lXBi4IZo0zXkJyeDza9dB1RiQFswa&client_secret=LAqQtlbWhG9EUOM0&grant_type=client_credentials&scope=SMS"
    token = JSON.parse(resp)["access_token"]
    header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
    puts "B:"
    puts @poll.message_sents.count
    
    @poll.message_sents.each do |message_sent|
      if message_sent.result.nil?
        result = JSON.parse(RestClient.get("https://api.telstra.com/v1/sms/messages/#{message_sent.message_id}/response", header))[0]
        puts result
        if result["content"][0] == "1"
          message_sent.result = 1
          message_sent.save!
        elsif result["content"][0] == "2"
          message_sent.result = 2
          message_sent.save!
        elsif message_sent.result = "3"
          # unsub
        end
      end
    end
    puts ":B"
    yes = Option.where(poll: @poll, title: "Yes").first
    yes.votes = MessageSent.where(poll: @poll, result: 1).count
    yes.save!

    no = Option.where(poll: @poll, title: "No").first
    no.votes = MessageSent.where(poll: @poll, result: 2).count
    no.save!

    no_reply = Option.where(poll: @poll, title: "No reply").first
    no_reply.votes = MessageSent.where(poll: @poll).count - no.votes - yes.votes
    no_reply.save!

  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.user = current_user

    @poll.end_date = Date.today + 2

    @poll.save!

    @survey_takers = SurveyTaker.all

    yes = Option.new(title: "Yes", votes: 0, poll: @poll)
    yes.save!

    no = Option.new(title: "No", votes: 0, poll: @poll)
    no.save!

    no_reply = Option.new(title: "No reply", votes: SurveyTaker.where(confirmed: 1).count, poll: @poll)
    no_reply.save!

    
    resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=g29lXBi4IZo0zXkJyeDza9dB1RiQFswa&client_secret=LAqQtlbWhG9EUOM0&grant_type=client_credentials&scope=SMS"
    token = JSON.parse(resp)["access_token"]
    header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}

    @survey_takers.each do |survey_taker|
      if survey_taker.confirmed == 0
        result = JSON.parse(RestClient.get("https://api.telstra.com/v1/sms/messages/#{survey_taker.message_id}/response", header))[0]
        puts "Brendon:"
        #puts JSON.parse(result)[0]["content"].inspect
        puts result
        puts result["content"]
        

        puts ":Brendon"

        if result["content"][0] == "1"
          survey_taker.confirmed = 1
          survey_taker.save!
        end
      end

      if survey_taker.confirmed == 1
        

        result = JSON.parse(RestClient.post "https://staging.api.telstra.com/v1/sms/messages", {to: survey_taker.number, body: @poll.question + " 1=Yes, 2=No, 3=Stop"}.to_json, header)
        @message_sent = MessageSent.new(poll: @poll, message_id: result["messageId"])

        @message_sent.save!

      end
    end

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.end_date = Date.today
    @poll.save!
    respond_to do |format|
      format.html { redirect_to poll_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:user_id, :user_id, :question, :subtext, :end_date, :poll, :poll_id)
    end
end
