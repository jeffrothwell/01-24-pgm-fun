def check_syntax(str)
  openables = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
  }
  open = []
  opening_chars = openables.keys  # all opening braces
  closing_chars = openables.values  # all closing braces

  str.each_char do |char|

    if opening_chars.include?(char) # opening bracket

      open << char    # shovel in char if it's an opener

    elsif closing_chars.include?(char) # closing bracket

      required_char = openables[open.last]  # the current closer must be the value in
                                            # openables at the key given by the last thing we
                                            # put in the open array
      if char == required_char # it's the right kind of closing bracket

        open.pop  # can remove last opening brace in open, we've closed it, we're good.

      else

        if open.any? # it's the wrong kind of closing bracket
          puts "* You have a syntax error: there is an unexpected #{char} where there should be a #{openables[open.last]}"
        else # there's nothing to close
          puts "* You have a syntax error: there is an unexpected #{char} where there is nothing to close."
        end

        return false  # aborts the whole method if we find one wrong closer (ie doesn't match with most recent open)
                      # or if we find a single closer with no opener
      end

    end
  end  # this is the end of the .each, now just need to check if there are any un-closed openables

  if open.size > 1 # multiple unclosed braces
    puts "* You have a sytax error: multiple unclosed braces. Add in the following order"
    open.each_index do |index|
      puts "* #{index + 1}. Closing #{openables[open[-(index + 1)]]}"
    end
  elsif open.size == 1  # single unclosed brace
    required_char = openables[open.first]
    puts "* You have a syntax error: the string ended without a closing #{required_char}"
  end

  return open.empty?  # hopefully at this point there's nothing in
end

puts check_syntax("(this)[] is some text")
puts "*****"
puts check_syntax("(this)] is some text")
puts "*****"
puts check_syntax("[(this] is some text")
puts "*****"
puts check_syntax("[this][ is some text")
puts "*****"
puts check_syntax("[this] is some text")
puts "*****"
puts check_syntax("<html> (this)[] is some text</html>")
puts "*****"
puts check_syntax("<html> (this)] is some text</html>")
puts "*****"
puts check_syntax("<html> [(this] is some text</html>")
puts "*****"
puts check_syntax("<html> [this][ is some text</html")
puts "*****"
puts check_syntax("<html> [this] is some text</html")
