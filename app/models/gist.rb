class Gist

  def initialize(options={})
    @options = options
    @user = @options[:user]
    @github = init_github_client
  end

  def publish
    init_swatch_options
    create_gist['html_url']
  rescue StandardError => ex
    puts "#{ex.class}: #{ex.message}"
    false
  end

  private

  def create_gist
    @github.gists.create(
      'login' => @user.identity.username,
      'description' => swatch_description,
      'public' => @options[:is_public],
      'files' => {
        swatch_filename => {
          'content' => "#{@swatch.instance_eval(@syntax)}"
        }
      }
    )
  end

  def swatch_description
    "#{@swatch.description} // via http://sw4tch.com/swatches/#{@swatch.id}"
  end

  def swatch_filename
    "#{@swatch.name.downcase.gsub(/\s/, '_')}.#{@filetype}"
  end

  def init_github_client
    Github.new oauth_token: @user.identity.token
  end

  def init_swatch_options
    @swatch = @options[:swatch]
    @filetype = @options[:syntax].gsub('stylus', 'styl')
    @syntax = @options[:syntax]
  end
end
