class Brancher
  def initialize working_dir=Dir.pwd
    @git = Git.open(working_dir)
    @current_branch = get_current_branch
  end

  def branch issue_num, description=nil
    @version_branch = find_version_branch
    merge_current_into_version
    delete_previous
    switch_to_new issue_num, description
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

  def merge_current_into_version
  end

  def delete_previous
  end

  def switch_to_new issue_num, description
    new_name = "i-#{issue_num}-#{description}"
  end
end