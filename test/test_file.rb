# encoding: UTF-8
unless defined? ASCIIDOCTOR_PROJECT_DIR
  $: << File.dirname(__FILE__); $:.uniq!
  require 'test_helper'
end

context "SUSE" do
  context 'External file' do
    test 'should parse a file' do
      input = File.read(ARGV.shift)
      doc = document_from_string input, :backend => 'docbook5', :header_footer => false
      output = doc.render
      puts output
    end
  end
end
