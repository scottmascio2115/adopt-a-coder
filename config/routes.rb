AdoptACoder::Application.routes.draw do

  root "home#index"

  resources "donors"
  resources "candidates" do
    resources "applications"
  end


end
