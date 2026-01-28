Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # /api/v1/kanji_characters
  namespace :api do
    namespace :v1 do
      resources :kanji_characters, only: %i[index show update] do
        collection do
          get :counts
          get :random
          get :ten_kanjis
        end
      end
      resources :learnt_kanjis
    end
  end
end
