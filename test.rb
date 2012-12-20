require 'test/unit'
  myfile = File.open("users.txt")
  $cards = myfile.readline(12)
  puts $cards
  puts $cards.class


class TestAssertion < Test::Unit::TestCase
  def test_not_nil
  	assert_equal( $cards, '0200A276E234', "nie te same")
  end
end