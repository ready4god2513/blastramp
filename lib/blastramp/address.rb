module Blastramp
  class Address < Entity
    has_properties :name, :line1, :line2, :line3, :city, :provstate, :country, :phone, :fax, :email, :web, :contact
    
    def initialize_defaults
      self.name = '' # Name as it appears on the ship to address label.
      self.line1 = '' # Street information (line 1) to appear on the ship to address label. Max total length of line1, line2 and line3 is 200 character
      self.line2 = ''
      self.line3 = ''
      self.city = '' # City name as on the ship to address label
      self.provstate = '' # Province/State as it appears on the ship to address label
      self.country = 'CA' # Country name as it appears on the ship to address label.
      self.phone = '--' # Phone number (any format). If not known submit "--"
      self.fax = '--' # Fax number (any format). If not known submit "--"
      self.email = '--' # Email address. If not known submit "--"
      self.web = '--' # Web site URL If not known submit "--"
      self.contact = '' # Contact person's full name at the location.
    end
    
    # Returns OrderedHash with the properties of Address in the correct order, camelcased and ready
    # to be sent via SOAP
    def soap_data
      data = ActiveSupport::OrderedHash.new
      data['name'] = name 
      data['line1'] = line1
      data['line2'] = line2
      data['line3'] = line3
      data['city'] = city
      data['provstate'] = provstate
      data['country'] = country
      data['phone'] = phone
      data['fax'] = fax
      data['email'] = email
      data['web'] = web
      data['contact'] = contact
            
      return data
    end
    
  end
end