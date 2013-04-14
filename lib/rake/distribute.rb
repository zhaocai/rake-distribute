#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rake'
require 'diffy'
require 'rake/distribute/version'

# monkey patch
require 'rake/distribute/task'


require 'rake/distribute/core'
require 'rake/distribute/dsl'

require 'rake/distribute/item'
require 'rake/distribute/item/file'
require 'rake/distribute/item/erbfile'
