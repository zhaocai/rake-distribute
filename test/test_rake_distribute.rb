require 'minitest/autorun'
require 'rake/distribute'
# require "minitest_helper"


class RakeDistributeTestCase < MiniTest::Unit::TestCase
  def setup
    self.extend Rake::Distribute::DSL
  end

  def test_sanity
    assert_raises(ArgumentError) {
      distribute :FileItem do
        from "/non-exist/file/path"
        to "/some/place"
      end
    }
  end
end
