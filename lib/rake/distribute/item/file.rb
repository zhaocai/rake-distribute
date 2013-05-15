require 'rake/distribute/item'
require 'diffy'

module Rake::Distribute
  module Item

    class FileItem < Base
      def initialize(&block)
        @diff_proc = Proc.new {|dest,src| puts "#{dest} differs from #{src}"}
        @build_dir = File.join('build','distribute')
        super
      end

      def sanity?
        super
        raise ArgumentError, "#{@src} does not exist!" unless File.exists?(@src)
      end

      def build(options = {}, &block)
        @build_options = options
        @build_proc = block if block_given?
      end

      def build_dir(folder)
        @build_dir = folder
      end

      def diff(&block)
        @diff_proc = block if block_given?
      end


      def define_tasks(options={})
        if defined? @build_proc
          build_dest = define_build_task(@src)
        else
          build_dest = nil
        end

        if defined? @dest
          if File.directory?(@dest)
            dest_folder = @dest
          else
            dest_folder = @dest.pathmap("%d")
            directory dest_folder
            file @dest => dest_folder
          end

          if build_dest

            file @dest => build_dest do
              if File.directory?(build_dest)
                cp_r build_dest, @dest, @dest_options
              else
                install build_dest, @dest, @dest_options
              end
            end

            desc "distribute: install"
            task :install => @dest


            define_diff_task(build_dest)

          else # without build ( install @src -> @dest )
            file @dest => @src do
              if File.directory?(@dest)
                cp_r @src, @dest, @dest_options
              else
                install @src, @dest, @dest_options
              end
            end

            desc "distribute: install"
            task :install => @dest

            define_diff_task(@src)
          end

          desc "distribute: uninstall"
          task :uninstall do
            if File.directory?(@dest)
              rmtree File.join(@dest, File.basename(@dest))
            else
              safe_unlink @dest
            end
          end


        end

      end


      def define_diff_task(from)
        return unless defined? @dest

        desc "distribute: diff"
        task :diff do
          diffy = Diffy::Diff.new(
            @dest, from, :source => 'files', :allow_empty_diff => true
          ).to_s(:text)

          @diff_proc.call(@dest, @src) unless diffy.empty?
        end
      end


      def define_build_task(from)

        build_dest = File.join(@build_dir, build_to)

        build_dir = File.dirname(build_dest)
        directory build_dir
        file build_dest => [from, build_dir] do
          @build_proc.call(from, build_dest)
        end
        desc "distribute: build"
        task :build => build_dest

        desc "distribute: clean"
        task :clean do
          safe_unlink build_dest
        end

        desc "distribute: clobber"
        task :clobber => [:clean] do
          rmdir @build_dir
        end

        build_dest
      end

      private



      def build_to
        if @build_options and @build_options.has_key?(:to)
          @build_options[:to]
        else
          "#{Item.sn.to_s}-#{@src.pathmap('%n')}"
        end
      end

    end

  end
end
