note
    description : "this class implements is leap yeat check."
    date        : "$Date$"
    revision    : "$Revision$"

class
    LEAP_INITIAL

inherit
    ARGUMENTS

feature

	is_leap_year (y: INTEGER): BOOLEAN
	do
		if ((y \\ 4 = 0 and y \\ 100 /= 0) or (y \\ 400 = 0)) then
			Result := True
		else
			Result := False
		end
	end

end
