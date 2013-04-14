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
    end

    def distribute(item_class, options={}, &block)
      item = get_item_class(item_class).new(&block)
      item.sanity?
      item.define_tasks(options)
      @items << item
    end

    private

    def get_item_class(item_class)
      Rake::Distribute::Item.const_get(item_class)
    end
  end

end

