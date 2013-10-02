require 'rake/distribute/item'
require 'diffy'


class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.size || 0
    gsub(/^[ \t]{#{indent}}/, '')
  end
end


module Rake::Distribute
  module Item

    class FileItem < Base
      def initialize(&block)
        @diff_proc = Proc.new { |dest,src| puts "#{dest} differs from #{src}"}
        @build_dir = File.join('build', 'distribute')
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

      def uninstall(entries)
        @uninstall_entries = entries
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

          if build_dest

            if File.directory?(@dest)
              dest = File.join(@dest, File.basename(build_dest))
            else
              dest = @dest
            end

            dest_folder = File.dirname(dest)
            directory dest_folder

            file dest => [build_dest, dest_folder] do
              if File.directory?(build_dest)
                cp_r build_dest, @dest, @dest_options
              else
                install build_dest, @dest, @dest_options
              end
            end


            desc "distribute: install"
            task :install => dest


            define_diff_task(build_dest)

          else # without build ( install @src -> @dest )

            if File.directory?(@dest)
              dest_folder = @dest
            else
              dest_folder = @dest.pathmap("%d")
            end

            directory dest_folder

            file @dest => [@src, dest_folder] do
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
              uninstall_hint
            else
              safe_unlink @dest if File.exist?(@dest)
            end

            if defined? @uninstall_entries
              if @uninstall_entries.is_a?(String)
                if File.exist?(@uninstall_entries)
                  puts "remove_entry_secure #{@uninstall_entries}"
                  remove_entry_secure @uninstall_entries
                end
              elsif @uninstall_entries.is_a?(Array)
                @uninstall_entries.each { |e|
                  if File.exist?(e)
                    puts "remove_entry_secure #{e}"
                    remove_entry_secure e
                  end
                }
              end
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

        build_dest = get_build_dest

        build_dir = File.dirname(build_dest)
        directory build_dir
        file build_dest => [from, build_dir] do
          @build_proc.call(from, build_dest)
        end

        desc "distribute: build"
        task :build => build_dest

        desc "distribute: clean"
        task :clean do
          safe_unlink build_dest if File.exist?(build_dest)
        end

        desc "distribute: clobber"
        task :clobber => [:clean] do
          rmdir @build_dir if File.exist?(@build_dir)
        end

        build_dest
      end

      private


      def uninstall_hint
        if File.directory?(@dest) && !defined? @uninstall_entries
          puts %Q{
            rake/distribute: Uninstall directory is confusion!
            Specify it using `uninstall`:

            distribute :FileItem do
              uninstall '/path/to/foder/to/uninstall'
            end

          }.strip_heredoc

        end
      end

      def get_build_dest
        if @build_options && @build_options.has_key?(:to)
          @build_options[:to]
        else
          File.join(@build_dir, "#{Item.sn.to_s}-#{@src.pathmap('%n')}")
        end
      end

    end

  end
end
