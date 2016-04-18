class Ability
  include CanCan::Ability


  # CanCanCan automatically integrates with ApplicationController and it assumes that you have a method in your ApplicationController called current_user. You don't need to automatically create an Ability object (automatically done), we just need to learn how to write authorization rules and how to use them.
  def initialize(user)

    alias_action :create, :read, :update, :destroy, :to => :crud


    # we instantiate the user to User.new to avoid having user be nil if the user is not signed in. We assume here that "user" will be 'User.new', if the user is not signed in.
    user ||= User.new

    # here we are defining the ability to manage (do anything) with a question.
    # In the case below we put inside the block an expression that will return true or false. This will determine whether the user is allowed to manage a question or not. We called it :crud
    can :crud, Question do |q|
      q.user == user && user.persisted?
    end

    can :crud, Answer do |ans|
      (ans.question.user == user || ans.user == user) && user.persisted?
    end

    #This gives superpowers to the admin user by having the ability to manage everything. (all actions in all models)
    can :manage, :all if user.admin?


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
