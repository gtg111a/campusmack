module Metatags
   extend ActiveSupport::Concern
   
     included do
       append_before_filter :set_metatags
     end

     module ClassMethods
       def metatags(hash)
         @hash = hash
       end
     end

     private

     def set_metatags
       object = self.instance_variable_get("@#{self.class.to_s.underscore.split('_').first.singularize}")
       hash = self.class.instance_variable_get(:@hash)
       if object
         hash.each do |tag, method|
           value = object.send(method) if object.respond_to?(method)
           elsif tag == :canonical
             value = self.send(method, object)
           end
         end
       end
     end
     
end
