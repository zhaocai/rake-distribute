# -*- coding: utf-8 -*-
require 'rake/distribute/item/erbfile'
require 'rake/ext/string'
require 'tilt'
require 'ostruct'

module Rake::Distribute
  module Item

    class TiltFile < ErbFile
      def initialize(&block)
        Tilt.prefer Tilt::ErubisTemplate
        super
      end

      def prefer(tilt_template)
        begin
          Tilt.prefer tilt_template
        rescue NameError => e
          raise "rake/distribute: #{e.message}"
        end

      end

      def render(from, to)
        File.open(to, 'w') do |f|
          tilt = Tilt.new(from)
          f.write(tilt.render(ContextStruct.new(@context)))
          f.flush
        end
      end

    end
  end
end

