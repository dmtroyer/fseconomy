class FseImporter

  def self.uri(resource, params = {})
    params = params.with_indifferent_access
    yml_path = Rails.root.join('config', 'fse.yml')
    config = YAML.load(ERB.new(File.read(yml_path)).result)[resource]
    params.merge!(config[:params])
    raise 'userkey not present in configuration.' if params[:userkey].nil?

    URI::HTTP.build(host: config[:host], path: config[:path], query: params.to_query)
  end

end
