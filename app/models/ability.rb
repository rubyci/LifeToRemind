class Ability
  include CanCan::Ability

  def initialize(user)
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

    can [:create, :new], Contact

    if user.present? # additional permissions for logged in users (they can read their own posts)
      if user.admin? # additional permissions for administrators
        can :manage, :all
      else
        can :crud, User, user_id: user.id

        can :current_plan, ApplicationController

        can [:create, :new, :inicio], Plan
        can [:index, :show, :update, :edit, :destroy, :import_page, :import, :export, :update_selected_plan, :pdf, :swotedit, :destroy, :myplan], Plan do |plan|
          plan.user_id == user.id
        end

        can [:create, :new], Swotpart
        can [:update, :edit, :destroy], Swotpart do |swotpart|
          plan = Plan.find(swotpart.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Mission
        can [:index, :show, :update, :edit, :destroy, :update_selected_mission], Mission do |mission|
          mission.user_id == user.id
        end

        can [:create, :new], Csf
        can [:index, :update, :edit, :destroy, :update_selected_csf], Csf do |csf|
          csf.user_id == user.id
        end

        can [:create, :new], Vision
        can [:index, :show, :update, :edit, :destroy, :update_selected_vision], Vision do |vision|
          vision.user_id == user.id
        end

        can [:create, :new], Value
        can [:index, :show, :update, :edit, :destroy], Value do |value|
          plan = Plan.find(value.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Role
        can [:index, :show, :edit, :update, :destroy], Role do |role|
          plan = Plan.find(role.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Sphere
        can [:index, :show, :update, :edit, :destroy, :sphereobjectives], Sphere do |sphere|
          sphere.user_id == user.id
        end

        can [:create, :new], Objective
        can [:update, :edit, :destroy, :editobjective], Objective do |objective|
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Goal
        can [:update, :edit, :destroy], Goal do |goal|
          objective = Objective.find(goal.objective_id)
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end

        can [:create, :new], Activity
        can [:destroy, :checked], Activity do |act|
          goal = Goal.find(act.goal_id)
          objective = Objective.find(goal.objective_id)
          plan = Plan.find(objective.plan_id)
          plan.user_id == user.id
        end
      end
    end
  end
end
