module Rhinocatalog
  class Engine < ::Rails::Engine
    isolate_namespace Rhinocatalog

    require "actionpack/action_caching"
  end
end
