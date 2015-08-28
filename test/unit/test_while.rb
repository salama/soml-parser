require_relative "../parser_helper"

class TestWhile < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_while
    @input = <<HERE
while(1) do
  tmp = a
  puts(b)
end
HERE
    @input.chop!
    @parse_output = {:while=>"while", :while_cond=>{:integer=>"1"}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}], :end=>"end"}}
    @output = Ast::WhileExpression.new(Ast::IntegerExpression.new(1), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self))] )
    @root = :while_do
  end

  def pest_while_reverse
    @input =  "puts '1' while true "
    @parse_output = {:while=>"while", :while_cond=>{:integer=>"1"}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}], :end=>"end"}}
    @output = Ast::WhileExpression.new(Ast::IntegerExpression.new(1), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self))] )
    @root = :while_do
  end

  def test_while_method
    @input = <<HERE
while(1) do
  tmp = String.new()
  tmp.puts(i)
end
HERE
    @input.chop!
    @parse_output = {:while=>"while", :while_cond=>{:integer=>"1"}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:receiver=>{:module_name=>"String"}, :call_site=>{:name=>"new"}, :argument_list=>[]}}, {:receiver=>{:name=>"tmp"}, :call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"i"}}]}], :end=>"end"}}
    @output = Ast::WhileExpression.new(Ast::IntegerExpression.new(1), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::CallSiteExpression.new(:new, [] ,Ast::ModuleName.new(:String))), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:i)] ,Ast::NameExpression.new(:tmp))] )
    @root = :while_do
  end

  def test_big_while
    @input = <<HERE
while( n > 1) do
  tmp = a
  a = b
  b = tmp + b
  puts(b)
  n = n - 1
end
HERE
    @input.chop!
    @parse_output = {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}
    @output = Ast::WhileExpression.new(Ast::OperatorExpression.new(">", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::NameExpression.new(:b)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::OperatorExpression.new("+", Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:b))), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:n),Ast::OperatorExpression.new("-", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)))] )
    @root = :while_do
  end
end
