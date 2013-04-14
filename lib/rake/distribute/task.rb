module Rake

  class Task
    alias_method :_add_comment, :add_comment
    # Add a comment to the task. Ignore duplicated comment
    def add_comment(comment)
      return if @full_comment.eql?(comment)
      _add_comment(comment)
    end

  end # class Rake::Task
end

