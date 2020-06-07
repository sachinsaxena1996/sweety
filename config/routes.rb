Rails.application.routes.draw do
  resources :glucose_levels
  get '/new_daily_report', to: "glucose_levels#new_daily_report"
  post '/daily_report', to: "glucose_levels#daily_report"
  get '/new_month_to_date_report', to: "glucose_levels#new_month_to_date_report"
  post '/month_to_date_report', to: "glucose_levels#month_to_date_report"
  get '/new_monthly_report', to: "glucose_levels#new_monthly_report"
  post '/monthly_report', to: "glucose_levels#monthly_report"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "glucose_levels#index"
end
