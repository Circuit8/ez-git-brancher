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
    version_branches = @git.branches.local.select{ |branch|
      branch.name[0] == 'v'
    }

    case version_branches.size
    when 0
      raise 'no version branches found'
    when 1
      @version_branch = version_branches.first.name
    else
      raise'multiple version branches found'
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
    new_name = "i-#{issue_num}"
    if description
      hyphenated_description = description.gsub(' ', '-')
      new_name << "-#{hyphenated_description}"
    end 
    @git.branch(new_name).checkout
  end
end