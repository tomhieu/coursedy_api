Rails.application.routes.draw do
  namespace :affiliate do
    resources :agencies
  end
  namespace :cd_admin do
    resources :pages, only: [:index]
    resources :tutors, only: [:show, :edit, :update, :destroy, :index]
    resources :courses, only: [:show, :edit, :update, :destroy, :index]
    resources :categories
    get 'duo/new', to: "duo#new"
    post 'duo/verify', to: "duo#verify"
    devise_for :users, controllers: { sessions: 'cd_admin/sessions' }, only: [:sessions]
  end

  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/registrations', # full module nesting
    passwords: 'api/v1/passwords'
  }

  namespace :bigbluebutton do
    namespace :api, defaults: {format: :json} do
      resources :rooms, only: [:index] do
        member do
          get :join
        end
      end
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :exchange_rates, only: [:index]
      resources :change_password_requests, only: [:create]
      resources :accounts, only: [:show, :update, :index]
      resources :users, only: [:show] do
        collection do
          get :get_user
          post :connect_facebook
          post :connect_google
          get :enrolled_courses
          get :my_notifications
          get :followed_courses
          post :rate_teacher
          get :courses
          get :accounts
        end

        member do
          get :get_rating
          get :courses
        end
      end
      get :current_user, to: 'users#current_api_user'
      get :validate_email, to: 'users#validate_email'
      resources :categories, only: [:index]
      resources :locations, only: [:index]
      resources :courses, except: [:new, :edit] do
        collection do
          get :search
          get :related_courses
          get :upcomming_classes
          get :upcomming_teaching_classes
        end
        resources :comments, only: [:create, :index]
        member do
          get :participants
          post :view
          post :enroll
          get :user_enrolled
          post :follow
          get :get_rating
        end
      end
      resources :lessons, except: [:new, :edit]
      resources :course_sections, except: [:new, :edit]
      resources :documents, except: [:new, :edit]
      resources :degrees, only: [:create, :index, :destroy]
      resources :tutors, only: [:update, :show, :index] do
        resources :tutor_educations, only: [:create, :show, :update, :destroy, :index]
        resources :tutor_work_experiences, only: [:create, :show, :update, :destroy, :index]
        resources :tutor_reviews, only: [:create, :show, :update, :destroy, :index]
        collection do
          get :search
          get :top_teachers
          get :current_tutor, to: 'tutors#current_tutor'
          get :tutor_by_user, to: 'tutors#tutor_by_user'
        end

        member do
          get :courses
        end
      end
    end
  end
end
