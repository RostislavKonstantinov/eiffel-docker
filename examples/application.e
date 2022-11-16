note
	description: "leap_year application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE}

	y: LEAP_INITIAL

	make

	do
		create y
		print(y.is_leap_year (2004))

	end

end