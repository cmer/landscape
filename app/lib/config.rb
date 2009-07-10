module Landscape
  class Config
    def self.read
      YAML.load_file(File.join(Rails.root, "config", "config.yml"))
    end
  end
end