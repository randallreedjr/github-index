require_relative 'gitrepo.rb'

class GithubIndex

  attr_reader :path

  def initialize(base_dir = "~")
    @base_dir = base_dir
    @path = ""
    @index = ""
  end

  def generate_index
    puts write_header
    puts "Reading from #{@base_dir}"
    process_directory(@base_dir)
    puts "<ul>#{@index}</ul>"
    puts write_footer
  end

  private
  def write_header
    header = <<-HTML
<!doctype html>
<html>
  <head><title>Github Index</title></head>
  <body>
    <h1>Git Repository Index</h1>
    HTML
  end

  def process_directory(current_directory)
    contents = Dir.entries(current_directory).slice(2..-1)
    @path = Pathname.new(current_directory)
    if not contents.include?(".git")
      @index << "<li>#{path.basename}"
      contents.each do |content|
        if File.directory?("#{current_directory}/#{content}/")
          @index << "<ul>"
          process_directory("#{current_directory}/#{content}/")
          @index << "</ul>"
        end
      end
    else
      @index << print_repo(current_directory)      
    end
  end

  def print_repo(current_directory)
    repo = "#{@path.basename}"
    remote = find_remote(current_directory)
    repo = "<a href=\"#{remote}\">#{repo}</a>" unless remote.empty?
    return "<li>#{repo}"
  end

  def find_remote(current_directory)
    repo = GitRepo.new("#{current_directory}/.git/config")
    repo.find_remote
  end

  def write_footer
    footer = <<-HTML
    <h6>Generated by <a href="https://github.com/randallreedjr/github-index">github-index</a></h6>
  </body>
</html>
    HTML
  end

end