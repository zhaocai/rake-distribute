require 'rake/distribute/item'

module Rake::Distribute
  module Item

    class FileItem < Base
      def initialize(&block)
        @diff_block = Proc.new {|new,old| puts "#{new} differs from #{old}"}
        super
      end

      def sanity?
        super
        raise ArgumentError, "#{@from} does not exist!" unless File.exists?(@from)
      end

      def diff(&block)
        @diff_block = block if block_given?
      end

      def define_tasks
        # [TODO]( diff proc or diff action ) @zhaocai @start(2012-10-18 18:47)

        require 'diffy'
        namespace "distribute" do
          to_dir = @to.pathmap("%d")
          directory to_dir
          file @to => @from do
            install @from, @to
          end

          task :install => [to_dir, @to]

          task :uninstall do
            safe_unlink @to
          end

          task :diff do
            diff = Diffy::Diff.new(
              @to, @from, :source => 'files', :allow_empty_diff => true
            ).to_s(:text)

            @diff_block.call(@to, @from) unless diff.empty?
          end
        end
      end

    end

  end
end
