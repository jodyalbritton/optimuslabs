class Setting < RailsSettings::CachedSettings


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
