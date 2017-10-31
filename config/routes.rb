Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/registrations' # full module nesting
  }

  namespace :api do
    namespace :v1 do
      get :current_user, to: 'users#current_api_user'
      get :validate_email, to: 'users#validate_email'
      resources :categories, only: [:index]
      resources :courses
      resources :tutors, only: [:update] do
        collection do
          get :current_tutor, to: 'tutors#current_tutor'
        end
      end
    end
  end
end
