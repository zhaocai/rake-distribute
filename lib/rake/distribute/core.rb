# -*- coding: utf-8 -*-
require 'rake/dsl_definition'
require 'singleton'

module Rake::Distribute

  class Core
    include Singleton
    include Rake::DSL

    attr_accessor :build_dir
    attr_accessor :distribute_config_file
    attr_accessor :items


    def initialize
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

    def distribute(item_class, &block)
      item = get_item_class(item_class).new(&block)
      item.sanity?
      item.define_tasks
      @items << item
    end

    private

    def get_item_class(item_class)
      Rake::Distribute::Item.const_get(item_class)
    end
  end

end

