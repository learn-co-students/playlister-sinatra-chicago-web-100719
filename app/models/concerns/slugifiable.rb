module Slugifiable
    module InstanceMethods
        def slug
            name = self.name.gsub(" ","-")
            name.gsub(/[^0-9A-Za-z\-]/, "").downcase
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            self.all.find {|s| s.slug == slug}
        end
    end
end