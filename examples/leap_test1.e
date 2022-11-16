note
	description: ""
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LEAP_TEST1

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	test: LEAP_INITIAL

	on_prepare
			-- <Precursor>
		do
			create test
		end

feature -- Test routines

	leap_year_2000
			-- New test routine
		do
			assert ("Leap year: 2000", test.is_leap_year(2000) = True)

		end

		leap_year_1900
			-- New test routine
		do
			assert ("Leap year: 1900", test.is_leap_year(1900) = False)
		end

		leap_year_2018
			-- New test routine
		do
			assert ("Leap year: 2018", test.is_leap_year(2018) = False)
		end

		leap_year_1999
			-- New test routine
		do
			assert ("Leap year: 1999", test.is_leap_year(1999) = False)
		end

   leap_year_2012
			-- New test routine
		do
			assert ("Leap year: 2012", test.is_leap_year(2012) = True)
		end

end
