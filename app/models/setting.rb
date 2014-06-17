class Setting < RailsSettings::CachedSettings
 acts_as_list
	def find_class
		val = YAML.load(self[:value])
		if val == true
			"boolean"
		elsif val == false
			"boolean"
	    else 
	    	"string"
	    end


	end
end
