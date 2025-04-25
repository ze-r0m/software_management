Rails.application.routes.draw do
  # Devise: вход, выход, восстановление пароля
  devise_for :users, skip: [:registrations]

  # Главная страница
  root 'installed_softwares#index'

  # Всё, что внутри — только для залогиненных
  authenticate :user do
    # Админская зона: управление пользователями и ролями
    resources :users    # полный CRUD по пользователям
    resources :roles    # полный CRUD по ролям

    resources :request_soft_auds
    resources :class_softwares
    resources :faculties
    resources :cafedras
    resources :comp_classes
    resources :installed_softwares
    resources :request_softs
  end

  # Профиль (для всех залогиненных): посмотреть/редактировать свой аккаунт
  resource :profile,
           only: %i[show edit update],
           controller: 'users'

  # Только просмотр для модераторов
  authenticate :user, lambda { |u| u.role.name == 'moderator' } do
    resources :request_soft_auds,    only: %i[index show]
    resources :class_softwares,      only: %i[index show]
    resources :faculties,            only: %i[index show]
    resources :cafedras,             only: %i[index show]
    resources :comp_classes,         only: %i[index show]
    resources :installed_softwares,  only: %i[index show]
    resources :request_softs,        only: %i[index show]
    resources :users
  end
end
