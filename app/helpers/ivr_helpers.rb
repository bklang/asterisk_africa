module IVRHelpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def registered_url_for(id)
      "#{virginia_base_url}/documents/#{id}"
    end

    def cached_url_for(document, content_type, id = nil)
      id = Virginia::DocumentCache.store document, content_type, 900, id
      registered_url_for id
    end

    def virginia_base_url
      virginia_config = Adhearsion.config.virginia
      "http://#{virginia_config.host}:#{virginia_config.port}"
    end
  end

  # Make these class-level methods also available within intances that include this module
  %w(cached_url_for registered_url_for virginia_base_url).each do |class_method|
    class_method = class_method.to_sym
    define_method class_method, ClassMethods.instance_method(class_method)
  end
end
