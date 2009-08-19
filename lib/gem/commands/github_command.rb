require 'rubygems/command'
require 'rubygems/command_manager'
require 'octopi'
# require 'rubygems/uninstaller'
# require 'gem/prune/gem'
# require 'gem/prune/version'

class Gem::Commands::GithubCommand < Gem::Command

  def initialize
    super 'github', 'Show stats for the various Github versions of a gem'
  end

  def arguments
    "GEMNAME  the gem name to search for"
  end

  def usage
    "#{program_name} GEMNAME"
  end

  def execute
    name   = get_one_gem_name
    search = /^.+\-#{name}$/i
    dep    = Gem::Dependency.new search, Gem::Requirement.default
    specs  = Gem::SpecFetcher.fetcher.find_matching dep

    stats = specs.map do |(gem, source)|
      next unless source == 'http://gems.github.com'
      stats_from_github_gem_name(gem.first)
    end

    github_stats_sort(stats).each do |stat|
      say "%-30s fork:%-4s watchers:%-3d updated:%s" % [
        stat[:name],
        stat[:fork] ? 'yes' : 'no',
        stat[:watchers],
        stat[:updated]
      ]
    end
  rescue Exception => ex
    puts "Unhandled Exception: #{ex.message}"
  end

private ######################################################################

  def stats_from_github_gem_name(name)
    user_name, repository_name = name.split('-', 2)
    repository = Octopi::User.find(user_name).repository(repository_name)
    {
      :name     => name,
      :user     => user_name,
      :fork     => repository.fork?,
      :watchers => repository.watchers,
      :updated  => repository.commits.first.committed_date.split('T').first
    }
  end

  def github_stats_sort(stats)
    stats.partition { |stat| stat[:fork]     }.reverse.map do |stats|
      stats.sort_by { |stat| stat[:watchers] }.reverse
    end.flatten
  end

end
