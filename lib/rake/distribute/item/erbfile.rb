# -*- coding: utf-8 -*-
require 'rake/distribute/item/file'
require 'rake/ext/string'
require 'erb'
require 'ostruct'

module Rake::Distribute
  module Item

    class ContextStruct < OpenStruct
      def get_binding
        binding
      end
    end

    class ErbFile < FileItem
      def initialize(&block)
        @context   = {}
        super
         
        # if the user do not define build task
        @build_proc ||= Proc.new { |from, to|
          # unnecessary dup to make the workflow clear
          copy_entry from, to
        }
      end

      def with_context(context)
        @context = context
      end

      def render(from, to)
        File.open(to, 'w') do |f|
          erb = ERB.new(File.read(from))
          f.write(erb.result(ContextStruct.new(@context).get_binding))
          f.flush
        end
      end

      alias_method :super_define_build_task, :define_build_task
      def define_build_task(src)
        directory @build_dir
        render_dest = File.join(@build_dir,
                                "#{Item.sn.to_s}-#{@src.pathmap('%n')}")
        file render_dest => [@src, @build_dir] do
          render(@src, render_dest)
        end

        desc "distribute: clean"
        task :clean do
          safe_unlink render_dest
        end
        super_define_build_task(render_dest)
      end

    end

  end
end

