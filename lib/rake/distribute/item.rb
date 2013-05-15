# -*- coding: utf-8 -*-

require 'rake/dsl_definition'

module Rake::Distribute
  module Item
    @@serial_number = 0
    def self.sn
      @@serial_number += 1
    end

    class Base
      include Rake::DSL

      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      def from(source)
        @src = source
      end

      def to(dest, options = {})
        @dest_options = options
        @dest = dest
      end


      def diff(&block)
        raise NotImplementedError
      end

      def sanity?
        raise SyntaxError, "source: is not defined" unless defined? @src
      end

      def define_tasks
        raise NotImplementedError
      end
    end
  end
end
