Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/registrations' # full module nesting
  }

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get :enrolled_courses
          get :followed_courses
          post :rate_teacher
        end
      end
      get :current_user, to: 'users#current_api_user'
      get :validate_email, to: 'users#validate_email'
      resources :categories, only: [:index]
      resources :locations, only: [:index]
      resources :courses, except: [:new, :edit] do
        collection do
          get :search
        end
        resources :comments, only: [:create, :index]
        member do
          post :view
          post :enroll
          get :user_enrolled
          post :follow
        end
      end
      resources :lessons, except: [:new, :edit]
      resources :course_sections, except: [:new, :edit]
      resources :documents, except: [:new, :edit]
      resources :tutors, only: [:update] do
        collection do
          get :top_teachers
          get :current_tutor, to: 'tutors#current_tutor'
          get :tutor_by_user, to: 'tutors#tutor_by_user'
        end
      end
    end
  end
end
