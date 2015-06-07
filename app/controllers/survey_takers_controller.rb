class SurveyTakersController < InheritedResources::Base
  def new
    @survey_taker = SurveyTaker.new
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

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @survey_taker.save!
    respond_to do |format|
      format.html { redirect_to survey_taker_url, notice: 'survey_taker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def survey_taker_params
      params.require(:survey_taker).permit(:name, :number)
    end
end

