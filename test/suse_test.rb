# encoding: UTF-8
unless defined? ASCIIDOCTOR_PROJECT_DIR
  $: << File.dirname(__FILE__); $:.uniq!
  require 'test_helper'
end

context "SUSE" do
  context 'Substitutes' do
    test 'should process menu "+"' do
      para = block_from_string('menu:+[]', :attributes => {'experimental' => ''})
      assert_equal %q{<b class="menuref">+</b>}, para.sub_macros(para.source)
    end
    test 'should process [ in variablelist' do
      list = block_from_string "* [[replaceable]``system_type``]: This tag is used", :backend => 'docbook5'
      output = list.render
      assert_xpath '//replaceable', output, 1
    end
  end

  context 'Images' do

    test 'can render block image with empty caption' do
      input = <<-EOS
.
image::images/tiger.png[Tiger]
      EOS
      doc = document_from_string input
      assert_equal 1, doc.blocks[0].number
      output = doc.render
      assert_xpath '//*[@class="imageblock"]//img[@src="images/tiger.png"][@alt="Tiger"]', output, 1
      assert_xpath '//*[@class="imageblock"]/*[@class="title"][text() = "Figure 1. "]', output, 1
      assert_equal 1, doc.attributes['figure-number']
    end
    test 'can render block image with caption' do
      input = <<-EOS
.SUSE
image::images/tiger.png[Tiger]
      EOS
      doc = document_from_string input
      assert_equal 1, doc.blocks[0].number
      output = doc.render
      assert_xpath '//*[@class="imageblock"]//img[@src="images/tiger.png"][@alt="Tiger"]', output, 1
      assert_xpath '//*[@class="imageblock"]/*[@class="title"][text() = "Figure 1. SUSE"]', output, 1
      assert_equal 1, doc.attributes['figure-number']
    end
  end
end
