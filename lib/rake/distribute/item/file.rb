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

      def define_tasks
        namespace "distribute" do
          to_dir = @dest.pathmap("%d")
          directory to_dir
          file @dest => @src do
            install @src, @dest, @dest_options
          end

          task :install => [to_dir, @dest]

          task :uninstall do
            safe_unlink @dest
          end

          task :diff do
            diff = Diffy::Diff.new(
              @dest, @src, :source => 'files', :allow_empty_diff => true
            ).to_s(:text)

            @diff_proc.call(@dest, @src) unless diff.empty?
          end
        end
      end

    end

  end
end
