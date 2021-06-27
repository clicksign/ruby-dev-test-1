require 'uri'
require 'open-uri'

module FactoryHelpers
  def open_archive_example
    begin
      url = Faker::Avatar.image
      filename = File.basename(URI.parse(url).path)
      file = URI.open(url)

      {file: file, filename: filename}
    rescue
      open_archive_example
    end
  end
end

FactoryBot::SyntaxRunner.send(:include, FactoryHelpers)
