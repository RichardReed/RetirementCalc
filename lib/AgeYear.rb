#Calclate age from year and year from age

require_relative 'Config'

class Fixnum

	def is_age
		@config_hash = ConfigFile.instance
		self - @config_hash.config['birth_year']
		#self - 1954
	end

	def is_year
		@config_hash = ConfigFile.instance
		self + @config_hash.config['birth_year']
		#self + 1954
	end
end
