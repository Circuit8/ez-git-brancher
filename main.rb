require 'git'

brancher = Brancher.new ARGV[1]
brancher.branch ARGV[0]


class Brancher

  def initialize working_dir=Dir.pwd
    @git = Git.open(working_dir)
    @current_branch = get_current_branch
  end

  def branch
    @version_branch = find_version_branch
    merge_into_version_branch
    delete_previous_branch
    switch_to_new_branch
  end

private

  def find_version_branch
    version_branches = @git.branches.select{ |branch|
      branch.name[0] == 'v'
    }

    case version_branches.size
    when 0
      raise StandardError 'no version branches found'
    when 1
      return version_branches.first
    else
      raise StandardError 'multiple version branches found'
    end
  end

  def get_current_branch
  end
end