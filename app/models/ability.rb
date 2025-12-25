# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    # базовые права для всех авторизованных
    can :read, :all

    if user.admin?
      # админ может всё
      can :manage, :all
    else
      # обычный пользователь может управлять только своим
      can :manage, Post, user_id: user.id
      can :manage, Comment, user_id: user.id
    end
  end
end