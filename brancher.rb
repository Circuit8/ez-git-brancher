class Brancher
  def initialize 
    @git = Git.open(Dir.pwd)
    @current_branch = @git.current_branch
  end

  def branch issue_num, description=nil
    find_version_branch
    checkout_version
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
      @version_branch = version_branches.first.name
    else
      raise StandardError 'multiple version branches found'
    end
  end

  def checkout_version  
    @git.branch(@version_branch).checkout
  end

  def merge_current_into_version
    @git.merge(@current_branch)
  end

  def delete_previous
    @git.branch(@current_branch).delete
  end

  def switch_to_new issue_num, description
    new_name = "i-#{issue_num}-#{description}"
    @git.branch(new_name).checkout
  end
end