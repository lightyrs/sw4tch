class Gist

  def initialize(options={})
    init_options(options)
    @github = init_github_client
  end

  def create_gist
    @github.gists.create(
      'login' => @user.identity.username,
      'description' => swatch_description,
      'public' => @options[:public],
      'files' => {
        swatch_filename => {
          'content' => %Q(#{@swatch.instance_eval(@options[:extension])})
        }
      }
    )
  end

  private

  def swatch_description
    "#{@swatch.description} // via http://sw4tch.com/swatches/#{@swatch.id}"
  end

  def swatch_filename
    "#{@swatch.name.downcase.gsub(/\s/, '_')}.#{@options[:extension]}"
  end

  def init_github_client
    Github.new oauth_token: @user.identity.token
  end

  def init_options(options)
    @options = options
    @user = @options[:user]
    @swatch = @options[:swatch]
  end
end
