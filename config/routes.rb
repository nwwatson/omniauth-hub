Rails.application.routes.draw do
  
  # OmniAuth callbacks
  get 'auth/:provider/callback' => 'user_sessions#create'
  get 'auth/failure'            => 'user_sessions#failure'
  
  # OmniAuth logout
  get 'logout' => 'user_sessions#destroy', :as => :logout
  
  # Organization switching
  get 'organizations'                           => 'organizations#index',  :as => :organizations
  get 'organizations(/:organization_id)/switch' => 'organizations#switch', :as => :switch_organization
end
