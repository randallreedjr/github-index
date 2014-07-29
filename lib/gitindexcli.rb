class GitIndexCLI
  attr_reader :directory, :path
  def initialize
    @filename = ""
  end

  def call
    if !mac_OS?
      puts "Sorry, this gem is only compatible with Mac OS"
    else
      greeting
      input = gets.chomp
      if input.downcase != "exit"
        directory_from_input(input)
        determine_path
        create_file
        `open #{@filename}`
      end
    end
  end

  private
  def greeting
    puts "What directory would you like to map?"
    puts "(leave blank for present working directory)"
  end

  def directory_from_input(input)
    input.strip.empty? ? @directory = (Dir.pwd) : @directory = input
  end

  def determine_path
    @path = Pathname.new(directory)
    @path = path.expand_path if path.relative?
  end

  def create_file
    #file = "#{path}/index.html"
    if !Dir.exists?('/tmp/gitindex')
      FileUtils::mkdir_p '/tmp/gitindex'
    end
    @filename = '/tmp/gitindex/index.html'
    puts "Mapping #{path}..."
    output_message
    $stdout.reopen(@filename, "w")
    GithubIndex.new(path).generate_index
  end

  def output_message
    puts "If results do not automatically open, type 'open #{@filename}'"
  end

  def mac_OS?
    return ((/darwin/ =~ RbConfig::CONFIG["arch"]) != nil)
  end
end