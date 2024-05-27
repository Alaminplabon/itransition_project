# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present?

    if user.is_admin?
      can :manage, :all
    else
      can :manage, :all, user: user
      can :manage, Comment
      can :manage, Like
      cannot :view, :all
    end

    if user.is_block?
      cannot :manage, :all
    end

    # return unless user.present?
    #
    #
    # can :manage, :all, user: user
    #
    # if user.is_block?
    #   cannot :manage, :all
    #   return
    # end
    #
    # return unless user.is_admin?
    # can :manage, :all
  end
end
