# -*- coding: utf-8 -*-
require 'rake/distribute/item/erbfile'
require 'rake/ext/string'
require 'tilt'
require 'ostruct'

module Rake::Distribute
  module Item

    class TiltFile < ErbFile
      def initialize(&block)
        super
      end

      def prefer(tilt_template)
        begin
          Tilt.prefer tilt_template
        rescue NameError => e
          raise "rake/distribute: #{e.message}"
        end

      end

      def define_build_task(options={})
        directory @build_dir

        build_file = File.join(@build_dir,
                               "#{Item.sn.to_s}-#{@src.pathmap('%n')}")
        file build_file => @src do
          File.open(build_file, 'w') do |f|
            tilt = Tilt.new(@src)
            f.write(tilt.render(ContextStruct.new(@context)))
            f.flush
          end
        end
        build_file
      end

    end

  end
end

