# -*- coding: utf-8 -*-
require 'rake/distribute/item/file'
require 'rake/ext/string'
require 'erb'
require 'ostruct'

module Rake::Distribute
  module Item

    class ErbContext < OpenStruct
      def get_binding
        binding
      end
    end

    class ErbFile < FileItem
      def initialize(&block)
        @context   = {}
        @build_dir = File.join('build','distribute')
        super
      end

      def sanity?
        super
        raise ArgumentError, "#{@src} does not exist!" unless File.exists?(@src)
      end

      def build_dir(folder)
        @build_dir = folder
      end

      def with_context(context)
        @context = context
      end

      def define_tasks(options={})

        dest_dir = @dest.pathmap("%d")
        directory dest_dir
        directory @build_dir

        build_file = File.join(@build_dir,
                               "#{Item.sn.to_s}-#{@src.pathmap('%n')}")
        file build_file => @src do
          File.open(build_file, 'w') do |f|
            erb = ERB.new(File.read(@src))
            f.write(erb.result(ErbContext.new(@context).get_binding))
            f.flush
          end
        end

        file @dest => build_file do
          install build_file, @dest, @dest_options
        end

        desc "distribute: build"
        task :build => [@build_dir, build_file]
        
        desc "distribute: install"
        task :install => [@build_dir, build_file, dest_dir, @dest]

        desc "distribute: uninstall"
        task :uninstall do
          safe_unlink @dest if File.exists?(@dest)
        end

        desc "distribute: clean"
        task :clean do
          safe_unlink build_file if File.exists?(build_file)
        end

        desc "distribute: clobber"
        task :clobber => [:clean] do
          rmdir @build_dir
        end

        desc "distribute: diff"
        task :diff => [@build_dir, build_file] do
          diff = Diffy::Diff.new(
            @dest, build_file, :source => 'files', :allow_empty_diff => true
          ).to_s(:text)

          @diff_proc.call(@dest, build_file) unless diff.empty?
        end
      end

    end

  end
end

