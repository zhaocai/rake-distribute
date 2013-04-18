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

      def define_tasks(options={})

        dest_dir = @dest.pathmap("%d")
        directory dest_dir
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

