#!/usr/bin/env ruby
# -*- coding: utf-8 -*-


module Rake::Distribute

  class Core
    include Singleton
    include Rake::DSL

    attr_accessor :build_dir
    attr_accessor :distribute_config_file
    attr_accessor :items


    def initialize
      @serial_number = 1
      @items = []

      # unify task descriptions
      namespace :distribute do
        desc "distribute"
        task :install

        desc "build for distribution"
        task :build

        desc "clean temporary items"
        task :clean

        desc "clean all unnecessary items"
        task :clobber => :clean

        desc "diff the distributed from the source"
        task :diff

        desc "uninstall the distributed"
        task :uninstall
      end
      task :clean => "distribute:clean"
      task :clobber => "distribute:clobber"
    end

    def define_tasks

      namespace "distribute" do

        directory build_dir

        digits = items.count.to_s.length
        i = 0
        items.each do |item|

          case File.extname(item[:from])
          when '.erb'
            item[:build] = File.join(build_dir,
                                     i.to_s.rjust(digits, '0'),
                                     item[:from].pathmap('%n'))

            file item[:build] => item[:from] do
              context = item.has_key?(:context) ? item[:context] : {}
              File.open(item[:build], 'w') do |f|
                f.write(ERB.new(File.read(item[:from])).result(binding))
                f.flush
              end
            end
          else
            item[:build] = File.join(build_dir,
                                     i.to_s.rjust(digits, '0'),
                                     item[:from].pathmap('%f'))

            file item[:build] => item[:from] do
              copy_file item[:from], build_to
            end
          end

          file item[:to] => item[:build] do
            install item[:build], item[:to]
          end

          i += 1
        end

        desc "distribute build"
        multitask :build =>
          [build_dir] + items.map{ |item| item[:build]}

        desc "distribute install"
        task :install => items.map{ |item| item[:to]}

        desc "distribute uninstall"
        task :uninstall do
          safe_unlink items.map{ |item| item[:to]}
        end

        desc "distribute diff"
        multitask :diff => :build do
          items.each { |item|
            diff = Diffy::Diff.new(
              item[:build], item[:to], :source => 'files', :allow_empty_diff => true
            ).to_s(:text)
            puts diff unless diff.empty?
          }
        end

        CLEAN.include(items.map{ |item| item[:build]})
        CLOBBER.include(build_dir)
      end
    end

    def distribute(item_class, &block)
      item = get_item_class(item_class).new(&block)
      item.sanity?
      item.define_tasks
      @items << item
    end

    private
    def sn
      @serial_number += 1
    end

    def get_item_class(item_class)
      Rake::Distribute::Item.const_get(item_class)
    end
  end

end

