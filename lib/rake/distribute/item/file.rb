require 'rake/distribute/item'
require 'diffy'

module Rake::Distribute
  module Item

    class FileItem < Base
      def initialize(&block)
        @diff_proc = Proc.new {|dest,src| puts "#{dest} differs from #{src}"}
        super
      end

      def sanity?
        super
        raise ArgumentError, "#{@src} does not exist!" unless File.exists?(@src)
      end

      def to(dest, options={})
        @dest = dest
        @dest_options = options
      end

      def diff(&block)
        @diff_proc = block if block_given?
      end

      def define_tasks(options={})
        dest_folder = @dest.pathmap("%d")
        directory dest_folder
        file @dest => @src do
          install @src, @dest, @dest_options
        end

        desc "distribute: install"
        task :install => [dest_folder, @dest]

        desc "distribute: uninstall"
        task :uninstall do
          safe_unlink @dest
        end

        desc "distribute: diff"
        task :diff do
          diffy = Diffy::Diff.new(
            @dest, @src, :source => 'files', :allow_empty_diff => true
          ).to_s(:text)

          @diff_proc.call(@dest, @src) unless diffy.empty?
        end
      end

    end

  end
end
