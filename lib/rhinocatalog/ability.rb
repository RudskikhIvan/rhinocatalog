module Rhinocatalog
  module Ability
    extend ActiveSupport::Concern

    included do
      alias_method_chain :initialize, :rhinocatalog
    end

    def initialize_with_rhinocatalog(user)

      user ||= Rhinoart::User.new
      initialize_without_rhinocatalog(user)

      return if !user.approved? or !user.admin?

      if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER)
        can :manage, :catalog
      end

    end
  end
end