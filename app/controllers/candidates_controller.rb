class CandidatesController < ApplicationController
  def new
    @candidate = Candidate.new
  end

  def index
    if params[:search]
      @candidates = Candidate.order("RANDOM()").search(params[:search])
    else
      @candidates = Candidate.order("RANDOM()")
    end
  end

  def create
      @candidate = Candidate.new(candidate_params)
      if @candidate.save
        session[:id] = @candidate.id
        Application.create(candidate_id: @candidate.id)
        redirect_to candidate_path(@candidate)
      else
        flash[:error] = "Invalid Parameters. Please try again."
        render :new
      end
  end

  def edit

  end

  def update
    current_user.update_attributes(update_params)
    redirect_to edit_candidate_path(current_user)
  end

  def show
    @candidate = Candidate.find(params[:id])
    @responses = @candidate.responses
  end

private

def candidate_params
  params.require(:candidate).permit(:name, :email, :phone, :password, :password_confirmation, :address1, :address2, :city, :state, :zip)
end

def  update_params
  params.require(:candidate).permit(:address1, :address2, :city, :state, :zip, :twitter, :facebook, :linked_in, :codeacademy, :github, :blog, :personal_url, :mission, :biography,:currently_working_on)
end

end
