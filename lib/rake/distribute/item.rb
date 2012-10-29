#!/usr/bin/env ruby
# -*- coding: utf-8 -*-


module Rake::Distribute
  module Item
    class Base
      include Rake::DSL

      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      def from(where)
        @from = where
      end

      def to(where)
        @to = where
      end

      def diff(&block)
        raise NotImplementedError
      end

      def sanity?
        raise SyntaxError, "from: is not defined" unless defined? @from
        raise SyntaxError, "to: is not defined" unless defined? @to
      end

      def define_tasks
        raise NotImplementedError
      end
    end

    class ErbFile < Base
      def initialize(&block)
        super
      end

      def define_tasks
        raise NotImplementedError
      end
    end
  end
end
