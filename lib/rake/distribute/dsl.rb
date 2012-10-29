module Rake::Distribute
  # Adds `distribute` method to the top-level namespace.
  module DSL
    # Distribute an item to some place
    #
    # ## Examples:
    #
    #   distribute :Item do
    #     from "/path/from"
    #     to "/path/to"
    #   end
    def distribute(item_class, &block)
      Rake::Distribute::Core.instance.distribute(item_class, &block)
    end
  end
end

self.extend Rake::Distribute::DSL
