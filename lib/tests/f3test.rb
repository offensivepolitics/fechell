require "rubygems"
require "fechell"

require "fechell/forms"

require 'test/unit'


require 'test/unit/ui/console/testrunner'

class TC_FECTestForm3 < Test::Unit::TestCase
	def setup
		@testfiles = {}
		@testfiles["3.00"] = "tests/testdata/F3-3.00-32933.fec"
		@testfiles["5.00"] = "tests/testdata/F3-5.00-97348.fec"
		@testfiles["5.1"] = "tests/testdata/F3-5.1-126642.fec"
		@testfiles["5.2"] = "tests/testdata/F3-5.2-170434.fec"
		@testfiles["5.3"] = "tests/testdata/F3-5.3-210119.fec"
		@testfiles["6.1"] = "tests/testdata/F3-6.1-332675.fec"
		@testfiles["6.2"] = "tests/testdata/F3-6.2-350353.fec"
		@testfiles["6.3"] = "tests/testdata/F3-6.3-413014.fec"
		@testfiles["6.4"] = "tests/testdata/F3-6.4-424094.fec"
		@testfiles["7.0"] = "tests/testdata/F3-7.0-723958.fec"
    @testfiles["8.0"] = "tests/testdata/F3-8.0-748835.fec"
	end

	def test_v300
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["3.00"])
		
		h.process(@testfiles["3.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00256131", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Friends of Jennifer Dunn", f.committee_name)

				assert_equal("P.O. Box 40110", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Bellevue", f.city)
				assert_equal("WA", f.state)
				assert_equal("98015", f.zip)
				
				assert_equal("WA", f.election_state)
				assert_equal("08", f.election_district)

				assert_equal("Q1", f.report_code)
				
				assert_equal("P2002", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20020101", f.date_from_coverage)
				assert_equal("20020331", f.date_through_coverage)
				assert_equal("20020415", f.date_signed)

				assert_equal('295949.72', f.col_A_line_6a)
				assert_equal('1500.00', f.col_A_line_6b)
				assert_equal('294449.72', f.col_A_line_6c)
				assert_equal('111042.79', f.col_A_line_7a)
				assert_equal('910.40', f.col_A_line_7b)
				assert_equal('110132.39', f.col_A_line_7c)
				assert_equal('707058.54', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('', f.col_A_line_10)
				assert_equal('152281.11', f.col_A_line_11ai)
				assert_equal('102346.00', f.col_A_line_11aii)
				assert_equal('254627.11', f.col_A_line_11aiii)
				assert_equal('877.61', f.col_A_line_11b)
				assert_equal('40445.00', f.col_A_line_11c)
				assert_equal('', f.col_A_line_11d)
				assert_equal('295949.72', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('', f.col_A_line_13c)
				assert_equal('910.40', f.col_A_line_14)
				assert_equal('1758.77', f.col_A_line_15)
				assert_equal('298618.89', f.col_A_line_16)
				assert_equal('111042.79', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('', f.col_A_line_19c)
				assert_equal('1500.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('1500.00', f.col_A_line_20d)
				assert_equal('0.00', f.col_A_line_21)
				assert_equal('112542.79', f.col_A_line_22)
				assert_equal('520982.44', f.col_A_line_23)
				assert_equal('298618.89', f.col_A_line_24)
				assert_equal('819601.33', f.col_A_line_25)
				assert_equal('112542.79', f.col_A_line_26)
				assert_equal('707058.54', f.col_A_line_27)
				assert_equal('1132354.30', f.col_B_line_6a)
				assert_equal('1500.00', f.col_B_line_6b)
				assert_equal('1130854.30', f.col_B_line_6c)
				assert_equal('592608.34', f.col_B_line_7a)
				assert_equal('3935.77', f.col_B_line_7b)
				assert_equal('588672.57', f.col_B_line_7c)
				assert_equal('0.00', f.col_B_line_11ai)
				assert_equal('0.00', f.col_B_line_11aii)
				assert_equal('740930.78', f.col_B_line_11aiii)
				assert_equal('1282.09', f.col_B_line_11b)
				assert_equal('390141.43', f.col_B_line_11c)
				assert_equal('', f.col_B_line_11d)
				assert_equal('1132354.30', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('3935.77', f.col_B_line_14)
				assert_equal('4573.80', f.col_B_line_15)
				assert_equal('1140863.87', f.col_B_line_16)
				assert_equal('592608.34', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('', f.col_B_line_19b)
				assert_equal('', f.col_B_line_19c)
				assert_equal('1500.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('0.00', f.col_B_line_20c)
				assert_equal('1500.00', f.col_B_line_20d)
				assert_equal('0.00', f.col_B_line_21)
				assert_equal('594108.34', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v500
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["5.00"])
		
		h.process(@testfiles["5.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00256131", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Friends of Jennifer Dunn", f.committee_name)

				assert_equal("P.O. Box 40110", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Bellevue", f.city)
				assert_equal("WA", f.state)
				assert_equal("98015", f.zip)
				
				assert_equal("WA", f.election_state)
				assert_equal("08", f.election_district)

				assert_equal("Q3", f.report_code)
				
				assert_equal("P2004", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20030701", f.date_from_coverage)
				assert_equal("20030930", f.date_through_coverage)
				assert_equal("20031014", f.date_signed)

				assert_equal('222488.60', f.col_A_line_6a)
				assert_equal('0.00', f.col_A_line_6b)
				assert_equal('222488.60', f.col_A_line_6c)
				assert_equal('135359.71', f.col_A_line_7a)
				assert_equal('45.21', f.col_A_line_7b)
				assert_equal('135314.50', f.col_A_line_7c)
				assert_equal('1153150.31', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('', f.col_A_line_10)
				assert_equal('127005.00', f.col_A_line_11ai)
				assert_equal('25466.00', f.col_A_line_11aii)
				assert_equal('152471.00', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('70017.60', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('222488.60', f.col_A_line_11e)
				assert_equal('', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('45.21', f.col_A_line_14)
				assert_equal('2133.30', f.col_A_line_15)
				assert_equal('224667.11', f.col_A_line_16)
				assert_equal('135359.71', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('0.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('0.00', f.col_A_line_20d)
				assert_equal('17000.00', f.col_A_line_21)
				assert_equal('152359.71', f.col_A_line_22)
				assert_equal('1080842.91', f.col_A_line_23)
				assert_equal('224667.11', f.col_A_line_24)
				assert_equal('1305510.02', f.col_A_line_25)
				assert_equal('152359.71', f.col_A_line_26)
				assert_equal('1153150.31', f.col_A_line_27)
				assert_equal('637320.86', f.col_B_line_6a)
				assert_equal('4000.00', f.col_B_line_6b)
				assert_equal('633320.86', f.col_B_line_6c)
				assert_equal('354283.99', f.col_B_line_7a)
				assert_equal('640.64', f.col_B_line_7b)
				assert_equal('353643.35', f.col_B_line_7c)
				assert_equal('0.00', f.col_B_line_11ai)
				assert_equal('0.00', f.col_B_line_11aii)
				assert_equal('389116.83', f.col_B_line_11aiii)
				assert_equal('98.00', f.col_B_line_11b)
				assert_equal('248106.03', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('637320.86', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('640.64', f.col_B_line_14)
				assert_equal('6990.93', f.col_B_line_15)
				assert_equal('644952.43', f.col_B_line_16)
				assert_equal('354283.99', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('0.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('4000.00', f.col_B_line_20c)
				assert_equal('4000.00', f.col_B_line_20d)
				assert_equal('57150.00', f.col_B_line_21)
				assert_equal('415433.99', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v51
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["5.1"])
		
		h.process(@testfiles["5.1"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00372102", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Jim Gerlach for Congress Committee", f.committee_name)

				assert_equal("911 Welsh Ayres Way", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Downingtown", f.city)
				assert_equal("PA", f.state)
				assert_equal("193351689", f.zip)
				
				assert_equal("PA", f.election_state)
				assert_equal("", f.election_district)

				assert_equal("Q2", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("20041102", f.date_of_election)
				assert_equal("PA", f.state_of_election)
				assert_equal("20040408", f.date_from_coverage)
				assert_equal("20040630", f.date_through_coverage)
				assert_equal("20040714", f.date_signed)

				assert_equal('353302.67', f.col_A_line_6a)
				assert_equal('0', f.col_A_line_6b)
				assert_equal('353302.67', f.col_A_line_6c)
				assert_equal('108203.77', f.col_A_line_7a)
				assert_equal('0', f.col_A_line_7b)
				assert_equal('108203.77', f.col_A_line_7c)
				assert_equal('873350.1', f.col_A_line_8)
				assert_equal('0', f.col_A_line_9)
				assert_equal('0', f.col_A_line_10)
				assert_equal('115700.05', f.col_A_line_11ai)
				assert_equal('12494.86', f.col_A_line_11aii)
				assert_equal('128194.91', f.col_A_line_11aiii)
				assert_equal('300', f.col_A_line_11b)
				assert_equal('224807.76', f.col_A_line_11c)
				assert_equal('0', f.col_A_line_11d)
				assert_equal('353302.67', f.col_A_line_11e)
				assert_equal('0', f.col_A_line_12)
				assert_equal('0', f.col_A_line_13a)
				assert_equal('0', f.col_A_line_13b)
				assert_equal('0', f.col_A_line_13c)
				assert_equal('0', f.col_A_line_14)
				assert_equal('579.92', f.col_A_line_15)
				assert_equal('353882.59', f.col_A_line_16)
				assert_equal('108203.77', f.col_A_line_17)
				assert_equal('0', f.col_A_line_18)
				assert_equal('0', f.col_A_line_19a)
				assert_equal('0', f.col_A_line_19b)
				assert_equal('0', f.col_A_line_19c)
				assert_equal('0', f.col_A_line_20a)
				assert_equal('0', f.col_A_line_20b)
				assert_equal('0', f.col_A_line_20c)
				assert_equal('0', f.col_A_line_20d)
				assert_equal('0', f.col_A_line_21)
				assert_equal('108203.77', f.col_A_line_22)
				assert_equal('627671.28', f.col_A_line_23)
				assert_equal('353882.59', f.col_A_line_24)
				assert_equal('981553.87', f.col_A_line_25)
				assert_equal('108203.77', f.col_A_line_26)
				assert_equal('873350.1', f.col_A_line_27)
				assert_equal('1393390.91', f.col_B_line_6a)
				assert_equal('600', f.col_B_line_6b)
				assert_equal('1392790.91', f.col_B_line_6c)
				assert_equal('551046.46', f.col_B_line_7a)
				assert_equal('0', f.col_B_line_7b)
				assert_equal('551046.46', f.col_B_line_7c)
				assert_equal('', f.col_B_line_11ai)
				assert_equal('', f.col_B_line_11aii)
				assert_equal('683707.15', f.col_B_line_11aiii)
				assert_equal('1600', f.col_B_line_11b)
				assert_equal('708083.76', f.col_B_line_11c)
				assert_equal('0', f.col_B_line_11d)
				assert_equal('1393390.91', f.col_B_line_11e)
				assert_equal('0', f.col_B_line_12)
				assert_equal('0', f.col_B_line_13a)
				assert_equal('0', f.col_B_line_13b)
				assert_equal('0', f.col_B_line_13c)
				assert_equal('0', f.col_B_line_14)
				assert_equal('6201.23', f.col_B_line_15)
				assert_equal('1399592.14', f.col_B_line_16)
				assert_equal('551046.46', f.col_B_line_17)
				assert_equal('0', f.col_B_line_18)
				assert_equal('0', f.col_B_line_19a)
				assert_equal('0', f.col_B_line_19b)
				assert_equal('0', f.col_B_line_19c)
				assert_equal('600', f.col_B_line_20a)
				assert_equal('0', f.col_B_line_20b)
				assert_equal('0', f.col_B_line_20c)
				assert_equal('600', f.col_B_line_20d)
				assert_equal('0', f.col_B_line_21)
				assert_equal('551646.46', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v52
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["5.2"])
		
		h.process(@testfiles["5.2"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00346114", f.committee_fecid)
				assert_equal(" ", f.change_of_address)
				assert_equal("People With Hart", f.committee_name)

				assert_equal("P.O. Box 435", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Pittsburgh", f.city)
				assert_equal("PA", f.state)
				assert_equal("15090   ", f.zip)
				
				assert_equal("PA", f.election_state)
				assert_equal("4", f.election_district)

				assert_equal("Q1", f.report_code)
				
				assert_equal("P2006", f.election_code)

				assert_equal("20061107", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20050101", f.date_from_coverage)
				assert_equal("20050331", f.date_through_coverage)
				assert_equal("20050413", f.date_signed)

				assert_equal('118388.82', f.col_A_line_6a)
				assert_equal('0.00', f.col_A_line_6b)
				assert_equal('118388.82', f.col_A_line_6c)
				assert_equal('70471.56', f.col_A_line_7a)
				assert_equal('0.00', f.col_A_line_7b)
				assert_equal('70471.56', f.col_A_line_7c)
				assert_equal('158205.41', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('0.00', f.col_A_line_10)
				assert_equal('54133.97', f.col_A_line_11ai)
				assert_equal('2762.00', f.col_A_line_11aii)
				assert_equal('56895.97', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('61492.85', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('118388.82', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('0.00', f.col_A_line_14)
				assert_equal('55.10', f.col_A_line_15)
				assert_equal('118443.92', f.col_A_line_16)
				assert_equal('70471.56', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('0.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('0.00', f.col_A_line_20d)
				assert_equal('9196.00', f.col_A_line_21)
				assert_equal('79667.56', f.col_A_line_22)
				assert_equal('119429.05', f.col_A_line_23)
				assert_equal('118443.92', f.col_A_line_24)
				assert_equal('237872.97', f.col_A_line_25)
				assert_equal('79667.56', f.col_A_line_26)
				assert_equal('158205.41', f.col_A_line_27)
				
				assert_equal('124890.12', f.col_B_line_6a)
				assert_equal('0.00', f.col_B_line_6b)
				assert_equal('124890.12', f.col_B_line_6c)
				assert_equal('142967.22', f.col_B_line_7a)
				assert_equal('438.95', f.col_B_line_7b)
				assert_equal('142528.27', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('59546.77', f.col_B_line_11aiii)
				assert_equal('0.00', f.col_B_line_11b)
				assert_equal('65343.35', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('124890.12', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('438.95', f.col_B_line_14)
				assert_equal('106.20', f.col_B_line_15)
				assert_equal('125435.27', f.col_B_line_16)
				assert_equal('142967.22', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('0.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('0.00', f.col_B_line_20c)
				assert_equal('0.00', f.col_B_line_20d)
				assert_equal('11196.00', f.col_B_line_21)
				assert_equal('154163.22', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v53
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["5.3"])
		
		h.process(@testfiles["5.3"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00414391", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Carney for Congress", f.committee_name)

				assert_equal("PO Box 38", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Dimock", f.city)
				assert_equal("PA", f.state)
				assert_equal("18816", f.zip)
				
				assert_equal("PA", f.election_state)
				assert_equal("10", f.election_district)

				assert_equal("YE", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20051001", f.date_from_coverage)
				assert_equal("20051231", f.date_through_coverage)
				assert_equal("20050412", f.date_signed)

				assert_equal('65976.81', f.col_A_line_6a)
				assert_equal('0.00', f.col_A_line_6b)
				assert_equal('65976.81', f.col_A_line_6c)
				assert_equal('4180.99', f.col_A_line_7a)
				assert_equal('0.00', f.col_A_line_7b)
				assert_equal('4180.99', f.col_A_line_7c)
				assert_equal('71926.13', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('2222.00', f.col_A_line_10)
				assert_equal('50215.49', f.col_A_line_11ai)
				assert_equal('13632.50', f.col_A_line_11aii)
				assert_equal('63847.99', f.col_A_line_11aiii)
				assert_equal('1550.00', f.col_A_line_11b)
				assert_equal('578.82', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('65976.81', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('0.00', f.col_A_line_14)
				assert_equal('0.00', f.col_A_line_15)
				assert_equal('65976.81', f.col_A_line_16)
				assert_equal('4180.99', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('0.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('0.00', f.col_A_line_20d)
				assert_equal('5857.33', f.col_A_line_21)
				assert_equal('10038.32', f.col_A_line_22)
				assert_equal('15987.64', f.col_A_line_23)
				assert_equal('65976.81', f.col_A_line_24)
				assert_equal('81964.45', f.col_A_line_25)
				assert_equal('10038.32', f.col_A_line_26)
				assert_equal('71926.13', f.col_A_line_27)
				
				assert_equal('87501.50', f.col_B_line_6a)
				assert_equal('0.00', f.col_B_line_6b)
				assert_equal('87501.50', f.col_B_line_6c)
				assert_equal('9718.04', f.col_B_line_7a)
				assert_equal('0.00', f.col_B_line_7b)
				assert_equal('9718.04', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('85372.68', f.col_B_line_11aiii)
				assert_equal('1550.00', f.col_B_line_11b)
				assert_equal('578.82', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('87501.50', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('0.00', f.col_B_line_14)
				assert_equal('0.00', f.col_B_line_15)
				assert_equal('87501.50', f.col_B_line_16)
				assert_equal('9718.04', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('0.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('0.00', f.col_B_line_20c)
				assert_equal('0.00', f.col_B_line_20d)
				assert_equal('5857.33', f.col_B_line_21)
				assert_equal('15575.37', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v61
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["6.1"])
		
		h.process(@testfiles["6.1"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00417501", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Dan Seals for Congress", f.committee_name)

				assert_equal("P.O. Box 584", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Wilmette", f.city)
				assert_equal("IL", f.state)
				assert_equal("60091", f.zip)
				
				assert_equal("IL", f.election_state)
				assert_equal("10", f.election_district)

				assert_equal("Q1", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20080117", f.date_from_coverage)
				assert_equal("20080331", f.date_through_coverage)
				assert_equal("20080415", f.date_signed)

				assert_equal('513641.11', f.col_A_line_6a)
				assert_equal('150.00', f.col_A_line_6b)
				assert_equal('513491.11', f.col_A_line_6c)
				assert_equal('398842.37', f.col_A_line_7a)
				assert_equal('0.00', f.col_A_line_7b)
				assert_equal('398842.37', f.col_A_line_7c)
				assert_equal('745275.11', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('0.00', f.col_A_line_10)
				assert_equal('384661.25', f.col_A_line_11ai)
				assert_equal('42954.86', f.col_A_line_11aii)
				assert_equal('427616.11', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('86025.00', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('513641.11', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('0.00', f.col_A_line_14)
				assert_equal('3458.79', f.col_A_line_15)
				assert_equal('517099.90', f.col_A_line_16)
				assert_equal('398842.37', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('150.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('150.00', f.col_A_line_20d)
				assert_equal('0.00', f.col_A_line_21)
				assert_equal('398992.37', f.col_A_line_22)
				assert_equal('627167.58', f.col_A_line_23)
				assert_equal('517099.90', f.col_A_line_24)
				assert_equal('1144267.48', f.col_A_line_25)
				assert_equal('398992.37', f.col_A_line_26)
				assert_equal('745275.11', f.col_A_line_27)
				
				assert_equal('1418403.38', f.col_B_line_6a)
				assert_equal('7250.00', f.col_B_line_6b)
				assert_equal('1411153.38', f.col_B_line_6c)
				assert_equal('782026.14', f.col_B_line_7a)
				assert_equal('3082.41', f.col_B_line_7b)
				assert_equal('778943.73', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('1272678.38', f.col_B_line_11aiii)
				assert_equal('0.00', f.col_B_line_11b)
				assert_equal('145725.00', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('1418403.38', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('3082.41', f.col_B_line_14)
				assert_equal('8825.04', f.col_B_line_15)
				assert_equal('1430310.83', f.col_B_line_16)
				assert_equal('782026.14', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('7250.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('0.00', f.col_B_line_20c)
				assert_equal('7250.00', f.col_B_line_20d)
				assert_equal('800.00', f.col_B_line_21)
				assert_equal('790076.14', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v62
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["6.2"])
		
		h.process(@testfiles["6.2"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00435974", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Andy Harris for Congress", f.committee_name)

				assert_equal("PO Box 1527", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Annapolis", f.city)
				assert_equal("MD", f.state)
				assert_equal("21404", f.zip)
				
				assert_equal("MD", f.election_state)
				assert_equal("01", f.election_district)

				assert_equal("Q2", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20080401", f.date_from_coverage)
				assert_equal("20080630", f.date_through_coverage)
				assert_equal("20080715", f.date_signed)

				assert_equal('431550.58', f.col_A_line_6a)
				assert_equal('0.00', f.col_A_line_6b)
				assert_equal('431550.58', f.col_A_line_6c)
				assert_equal('112171.06', f.col_A_line_7a)
				assert_equal('0.00', f.col_A_line_7b)
				assert_equal('112171.06', f.col_A_line_7c)
				assert_equal('609482.95', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('103500.00', f.col_A_line_10)
				assert_equal('221975.17', f.col_A_line_11ai)
				assert_equal('54421.94', f.col_A_line_11aii)
				assert_equal('276397.11', f.col_A_line_11aiii)
				assert_equal('5000.00', f.col_A_line_11b)
				assert_equal('150153.47', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('431550.58', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('100000.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('100000.00', f.col_A_line_13c)
				assert_equal('0.00', f.col_A_line_14)
				assert_equal('915.23', f.col_A_line_15)
				assert_equal('532465.81', f.col_A_line_16)
				assert_equal('112171.06', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('16500.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('16500.00', f.col_A_line_19c)
				assert_equal('0.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('0.00', f.col_A_line_20d)
				assert_equal('0.00', f.col_A_line_21)
				assert_equal('128671.06', f.col_A_line_22)
				assert_equal('205688.20', f.col_A_line_23)
				assert_equal('532465.81', f.col_A_line_24)
				assert_equal('738154.01', f.col_A_line_25)
				assert_equal('128671.06', f.col_A_line_26)
				assert_equal('609482.95', f.col_A_line_27)
				
				assert_equal('1905305.42', f.col_B_line_6a)
				assert_equal('2010.00', f.col_B_line_6b)
				assert_equal('1903295.42', f.col_B_line_6c)
				assert_equal('1401715.88', f.col_B_line_7a)
				assert_equal('0.00', f.col_B_line_7b)
				assert_equal('1401715.88', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('1543847.95', f.col_B_line_11aiii)
				assert_equal('5350.00', f.col_B_line_11b)
				assert_equal('356107.47', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('1905305.42', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('122000.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('122000.00', f.col_B_line_13c)
				assert_equal('0.00', f.col_B_line_14)
				assert_equal('4403.41', f.col_B_line_15)
				assert_equal('2031708.83', f.col_B_line_16)
				assert_equal('1401715.88', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('18500.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('18500.00', f.col_B_line_19c)
				assert_equal('2010.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('0.00', f.col_B_line_20c)
				assert_equal('2010.00', f.col_B_line_20d)
				assert_equal('0.00', f.col_B_line_21)
				assert_equal('1422225.88', f.col_B_line_22)
				break
			end
		end
		
	end


	def test_v64
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["6.4"])
		
		h.process(@testfiles["6.4"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00128868", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Barney Frank for Congress Committee", f.committee_name)

				assert_equal("PO Box 260", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Newtonville", f.city)
				assert_equal("MA", f.state)
				assert_equal("024600003", f.zip)
				
				assert_equal("MA", f.election_state)
				assert_equal("04", f.election_district)

				assert_equal("Q2", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20090401", f.date_from_coverage)
				assert_equal("20090630", f.date_through_coverage)
				assert_equal("20090715", f.date_signed)


				assert_equal('620622.78', f.col_A_line_6a)
				assert_equal('4800.00', f.col_A_line_6b)
				assert_equal('615822.78', f.col_A_line_6c)
				assert_equal('219177.41', f.col_A_line_7a)
				assert_equal('353.35', f.col_A_line_7b)
				assert_equal('218824.06', f.col_A_line_7c)
				assert_equal('403878.66', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('0.00', f.col_A_line_10)
				assert_equal('353490.00', f.col_A_line_11ai)
				assert_equal('71557.78', f.col_A_line_11aii)
				assert_equal('425047.78', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('195575.00', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('620622.78', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('353.35', f.col_A_line_14)
				assert_equal('0.00', f.col_A_line_15)
				assert_equal('620976.13', f.col_A_line_16)
				assert_equal('219177.41', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('4800.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('4800.00', f.col_A_line_20d)
				assert_equal('150000.00', f.col_A_line_21)
				assert_equal('373977.41', f.col_A_line_22)
				assert_equal('156879.94', f.col_A_line_23)
				assert_equal('620976.13', f.col_A_line_24)
				assert_equal('777856.07', f.col_A_line_25)
				assert_equal('373977.41', f.col_A_line_26)
				assert_equal('403878.66', f.col_A_line_27)
				
				assert_equal('827763.35', f.col_B_line_6a)
				assert_equal('20400.00', f.col_B_line_6b)
				assert_equal('807363.35', f.col_B_line_6c)
				assert_equal('401685.46', f.col_B_line_7a)
				assert_equal('1825.85', f.col_B_line_7b)
				assert_equal('399859.61', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('573613.97', f.col_B_line_11aiii)
				assert_equal('0.00', f.col_B_line_11b)
				assert_equal('254149.38', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('827763.35', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('1825.85', f.col_B_line_14)
				assert_equal('0.00', f.col_B_line_15)
				assert_equal('829589.20', f.col_B_line_16)
				assert_equal('401685.46', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('95000.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('95000.00', f.col_B_line_19c)
				assert_equal('9400.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('11000.00', f.col_B_line_20c)
				assert_equal('20400.00', f.col_B_line_20d)
				assert_equal('204000.00', f.col_B_line_21)
				assert_equal('721085.46', f.col_B_line_22)
				break
			end
		end
		
	end

	def test_v70
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["7.0"])
		
		h.process(@testfiles["7.0"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00374058", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("A Whole Lot of People for Grijalva Congressional Committee", f.committee_name)

				assert_equal("PO Box 1242", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Tucson", f.city)
				assert_equal("AZ", f.state)
				assert_equal("857021242", f.zip)
				
				assert_equal("AZ", f.election_state)
				assert_equal("07", f.election_district)

				assert_equal("Q1", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20110101", f.date_from_coverage)
				assert_equal("20110331", f.date_through_coverage)
				assert_equal("20110415", f.date_signed)

				assert_equal('53627.22', f.col_A_line_6a)
				assert_equal('225.00', f.col_A_line_6b)
				assert_equal('53402.22', f.col_A_line_6c)
				assert_equal('29283.70', f.col_A_line_7a)
				assert_equal('1565.94', f.col_A_line_7b)
				assert_equal('27717.76', f.col_A_line_7c)
				assert_equal('54722.23', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('1393.39', f.col_A_line_10)
				
				assert_equal('25600.00', f.col_A_line_11ai)
				assert_equal('7527.22', f.col_A_line_11aii)
				assert_equal('33127.22', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('20500.00', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('53627.22', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('1565.94', f.col_A_line_14)
				assert_equal('3000.00', f.col_A_line_15)
				assert_equal('58193.16', f.col_A_line_16)
				assert_equal('29283.70', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('200.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('25.00', f.col_A_line_20c)
				assert_equal('225.00', f.col_A_line_20d)
				assert_equal('4234.00', f.col_A_line_21)
				assert_equal('33742.70', f.col_A_line_22)
				assert_equal('30271.77', f.col_A_line_23)
				assert_equal('58193.16', f.col_A_line_24)
				assert_equal('88464.93', f.col_A_line_25)
				assert_equal('33742.70', f.col_A_line_26)
				assert_equal('54722.23', f.col_A_line_27)

				assert_equal('59356.52', f.col_B_line_6a)
				assert_equal('1770.00', f.col_B_line_6b)
				assert_equal('57586.52', f.col_B_line_6c)
				assert_equal('128287.06', f.col_B_line_7a)
				assert_equal('15041.68', f.col_B_line_7b)
				assert_equal('113245.38', f.col_B_line_7c)
				assert_equal('34604.70', f.col_B_line_11aiii)
				assert_equal('0.00', f.col_B_line_11b)
				assert_equal('24751.82', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('59356.52', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('15041.68', f.col_B_line_14)
				assert_equal('3000.00', f.col_B_line_15)
				assert_equal('77398.20', f.col_B_line_16)
				assert_equal('128287.06', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('1245.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('525.00', f.col_B_line_20c)
				assert_equal('1770.00', f.col_B_line_20d)
				assert_equal('25834.00', f.col_B_line_21)
				assert_equal('155891.06', f.col_B_line_22)
				
				break
			end
		end
		
	end
  
  def test_80
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["8.0"])
    h.process(@testfiles["8.0"]) do |line|
			schedule = line[0]
			values = line[1]
	    
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00374058", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("A Whole Lot of People for Grijalva Congressional Committee", f.committee_name)

				assert_equal("PO Box 1242", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Tucson", f.city)
				assert_equal("AZ", f.state)
				assert_equal("857021242", f.zip)
				
				assert_equal("AZ", f.election_state)
				assert_equal("07", f.election_district)

        assert_equal("Q3", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20110701", f.date_from_coverage)
				assert_equal("20110930", f.date_through_coverage)
				assert_equal("20111015", f.date_signed)

				assert_equal('47751.61', f.col_A_line_6a)
				assert_equal('0.00', f.col_A_line_6b)
				assert_equal('47751.61', f.col_A_line_6c)
				assert_equal('58341.00', f.col_A_line_7a)
				assert_equal('3.98', f.col_A_line_7b)
				assert_equal('58337.02', f.col_A_line_7c)
				assert_equal('59388.77', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('0.00', f.col_A_line_10)

				assert_equal('11500.00', f.col_A_line_11ai)
				assert_equal('10251.61', f.col_A_line_11aii)
				assert_equal('21751.61', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('26000.00', f.col_A_line_11c)
				assert_equal('0.00', f.col_A_line_11d)
				assert_equal('47751.61', f.col_A_line_11e)

				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('3.98', f.col_A_line_14)
				assert_equal('0.00', f.col_A_line_15)
				assert_equal('47755.59', f.col_A_line_16)
				assert_equal('58341.00', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('0.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('0.00', f.col_A_line_20c)
				assert_equal('0.00', f.col_A_line_20d)
				assert_equal('750.00', f.col_A_line_21)
				assert_equal('59091.00', f.col_A_line_22)
        
				assert_equal('70724.18', f.col_A_line_23)
				assert_equal('47755.59', f.col_A_line_24)
				assert_equal('118479.77', f.col_A_line_25)
				assert_equal('59091.00', f.col_A_line_26)
				assert_equal('59388.77', f.col_A_line_27)
        
        
        
				assert_equal('195940.65', f.col_B_line_6a)
				assert_equal('2370.00', f.col_B_line_6b)
				assert_equal('193570.65', f.col_B_line_6c)
				assert_equal('251619.99', f.col_B_line_7a)
				assert_equal('15973.02', f.col_B_line_7b)
				assert_equal('235646.97', f.col_B_line_7c)				
				assert_equal('106983.45', f.col_B_line_11aiii)
				assert_equal('5.38', f.col_B_line_11b)
				assert_equal('88951.82', f.col_B_line_11c)
				assert_equal('0.00', f.col_B_line_11d)
				assert_equal('195940.65', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('15973.02', f.col_B_line_14)
				assert_equal('3000.00', f.col_B_line_15)
				assert_equal('214913.67', f.col_B_line_16)				
				assert_equal('251619.99', f.col_B_line_17)
				
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('1845.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('525.00', f.col_B_line_20c)
				assert_equal('2370.00', f.col_B_line_20d)
				assert_equal('34750.00', f.col_B_line_21)
				assert_equal('288739.99', f.col_B_line_22)				
      end
    end		
  end


	def test_v63
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["6.3"])
		
		h.process(@testfiles["6.3"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			
			if schedule == "F3"
				assert_equal("C00458190", f.committee_fecid)
				assert_equal("", f.change_of_address)
				assert_equal("Fritchey for Us", f.committee_name)

				assert_equal("2539 N Southport Ave", f.street_1)
				assert_equal("", f.street_2)
				assert_equal("Chicago", f.city)
				assert_equal("IL", f.state)
				assert_equal("60614", f.zip)
				
				assert_equal("IL", f.election_state)
				assert_equal("05", f.election_district)

				assert_equal("Q1", f.report_code)
				
				assert_equal("", f.election_code)

				assert_equal("", f.date_of_election)
				assert_equal("", f.state_of_election)
				assert_equal("20090212", f.date_from_coverage)
				assert_equal("20090331", f.date_through_coverage)
				assert_equal("20090415", f.date_signed)


				assert_equal('304142.66', f.col_A_line_6a)
				assert_equal('27500.00', f.col_A_line_6b)
				assert_equal('276642.66', f.col_A_line_6c)
				assert_equal('665545.36', f.col_A_line_7a)
				assert_equal('2930.50', f.col_A_line_7b)
				assert_equal('662614.86', f.col_A_line_7c)
				assert_equal('11060.00', f.col_A_line_8)
				assert_equal('0.00', f.col_A_line_9)
				assert_equal('15962.48', f.col_A_line_10)
				assert_equal('214780.00', f.col_A_line_11ai)
				assert_equal('17618.00', f.col_A_line_11aii)
				assert_equal('232398.00', f.col_A_line_11aiii)
				assert_equal('0.00', f.col_A_line_11b)
				assert_equal('66944.66', f.col_A_line_11c)
				assert_equal('4800.00', f.col_A_line_11d)
				assert_equal('304142.66', f.col_A_line_11e)
				assert_equal('0.00', f.col_A_line_12)
				assert_equal('0.00', f.col_A_line_13a)
				assert_equal('0.00', f.col_A_line_13b)
				assert_equal('0.00', f.col_A_line_13c)
				assert_equal('2930.50', f.col_A_line_14)
				assert_equal('8.68', f.col_A_line_15)
				assert_equal('307081.84', f.col_A_line_16)
				assert_equal('665545.36', f.col_A_line_17)
				assert_equal('0.00', f.col_A_line_18)
				assert_equal('0.00', f.col_A_line_19a)
				assert_equal('0.00', f.col_A_line_19b)
				assert_equal('0.00', f.col_A_line_19c)
				assert_equal('24500.00', f.col_A_line_20a)
				assert_equal('0.00', f.col_A_line_20b)
				assert_equal('3000.00', f.col_A_line_20c)
				assert_equal('27500.00', f.col_A_line_20d)
				assert_equal('0.00', f.col_A_line_21)
				assert_equal('693045.36', f.col_A_line_22)
				assert_equal('397023.52', f.col_A_line_23)
				assert_equal('307081.84', f.col_A_line_24)
				assert_equal('704105.36', f.col_A_line_25)
				assert_equal('693045.36', f.col_A_line_26)
				assert_equal('11060.00', f.col_A_line_27)
				
				assert_equal('758452.66', f.col_B_line_6a)
				assert_equal('34000.00', f.col_B_line_6b)
				assert_equal('724452.66', f.col_B_line_6c)
				assert_equal('716269.90', f.col_B_line_7a)
				assert_equal('2930.50', f.col_B_line_7b)
				assert_equal('713339.40', f.col_B_line_7c)
				#assert_equal(' ', f.col_B_line_11ai)
				#assert_equal(' ', f.col_B_line_11aii)
				assert_equal('634958.00', f.col_B_line_11aiii)
				assert_equal('0.00', f.col_B_line_11b)
				assert_equal('118694.66', f.col_B_line_11c)
				assert_equal('4800.00', f.col_B_line_11d)
				assert_equal('758452.66', f.col_B_line_11e)
				assert_equal('0.00', f.col_B_line_12)
				assert_equal('0.00', f.col_B_line_13a)
				assert_equal('0.00', f.col_B_line_13b)
				assert_equal('0.00', f.col_B_line_13c)
				assert_equal('2930.50', f.col_B_line_14)
				assert_equal('11.74', f.col_B_line_15)
				assert_equal('761394.90', f.col_B_line_16)
				assert_equal('716269.90', f.col_B_line_17)
				assert_equal('0.00', f.col_B_line_18)
				assert_equal('0.00', f.col_B_line_19a)
				assert_equal('0.00', f.col_B_line_19b)
				assert_equal('0.00', f.col_B_line_19c)
				assert_equal('26900.00', f.col_B_line_20a)
				assert_equal('0.00', f.col_B_line_20b)
				assert_equal('7100.00', f.col_B_line_20c)
				assert_equal('34000.00', f.col_B_line_20d)
				assert_equal('65.00', f.col_B_line_21)
				assert_equal('750334.90', f.col_B_line_22)
				break
			end
		end
		
	end
end
    
Test::Unit::UI::Console::TestRunner.run(TC_FECTestForm3)