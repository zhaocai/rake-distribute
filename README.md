# rake-distribute

* home  :: https://github.com/zhaocai/rake-distribute
* rdoc  :: http://rubydoc.info/gems/rake-distribute/
* code  :: https://github.com/zhaocai/rake-distribute
* bugs  :: https://github.com/zhaocai/rake-distribute/issues

## DESCRIPTION:

Generate rake distribute:install, uninstall, and diff tasks to distribute items (files, templates, directories, etc.) to difference locations.

It is the saver to use rake tasks to manage 1 -> n file distribution. Commonly applied cases are runcom files, Makefiles, etc. Those files exists in many locations and are almost identical with slight difference. 


## INSTALL:

* `gem install rake-distribute`

## SYNOPSIS:

### Basic Usage

```ruby
distribute :FileItem do
  from "/path/from"
  to "/path/to"
end

distribute :ErbFile do
  build_dir "build/distribute" # optional
  from "/path/from.erb"
  to "/path/to"
  with_context {:a => 1, :b => 2} # optional
  diff do |dest, src| # optional
    sh %Q{vimdo diff "#{dest}" "#{src}"}
  end
end

distribute :TiltFile do
  prefer Tilt::BlueClothTemplate # optional
  from "/path/from"
  to "/path/to"
  with_context {:a => 1, :b => 2} # optional
end
```
### Include Simple Build Proc

```ruby
distribute :FileItem do
  build_dir "build/distribute" # optional
  from "/path/from.c"
  build :to => 'to' do |from, to|
    sh %Q{gcc "#{from}" -o "#{to}"}
  end
  to "/usr/bin/to"
end

```


## DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

## LICENSE:

Copyright (c) 2013 Zhao Cai <caizhaoff@gmail.com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.

