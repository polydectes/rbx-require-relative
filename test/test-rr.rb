require 'test/unit'

# require_relative the old-fashioned way...
require File.join(File.expand_path(File.dirname(__FILE__), 
                                   '../require_relative'))

class TestRR < Test::Unit::TestCase
  ## require 'tmpdir'
  def test_basic
    # The chdir is to make things harder.
    ## Dir.chdir(Dir.tmpdir) do 
      cur_dir  = File.basename(File.expand_path(File.dirname(__FILE__)))
      ['./foo', "../#{cur_dir}/bar"].each_with_index do |suffix, i|
        assert_equal(true, require_relative(suffix), 
                     "check require_relative(#{suffix})")
        # Check that the require_relative worked by checking to see of the
        # class from each file was imported.
        assert_equal(Class, (0 == i ? Foo : Bar).class)
        assert_equal(false, require_relative(suffix), 
                     "require_relative(#{suffix}) second time should be false")
      end
    ## end
  end
end
