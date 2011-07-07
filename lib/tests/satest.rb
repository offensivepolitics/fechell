require "rubygems"
require "fechell"

require "fechell/forms"

require 'test/unit'


require 'test/unit/ui/console/testrunner'

class TC_FECTestScheduleA < Test::Unit::TestCase
	def setup
		@testfiles = {}
		@testfiles["3.00"] = "tests/testdata/F3-3.00-32933.fec"
		@testfiles["5.00"] = "tests/testdata/F3-5.00-97348.fec"
		@testfiles["5.1"] = "tests/testdata/F3-5.1-126642.fec"
		@testfiles["5.2"] = "tests/testdata/F3-5.2-170434.fec"
		@testfiles["5.3"] = "tests/testdata/F3-5.3-210250.fec"
		@testfiles["6.1"] = "tests/testdata/F3-6.1-332675.fec"
		@testfiles["6.2"] = "tests/testdata/F3-6.2-350353.fec"
		@testfiles["6.3"] = "tests/testdata/F3-6.3-413014.fec"
		@testfiles["6.4"] = "tests/testdata/F3-6.4-424094.fec"		
		@testfiles["7.0"] = "tests/testdata/F3-7.0-723958.fec"
	end
	
	def test_v300
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["3.00"])
		
		h.process(@testfiles["3.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
		
			
			if schedule == "SA"			
				assert_equal('C00256131', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Ackerley', f.contributor_last_name)
				assert_equal('Ginger', f.contributor_first_name)
				assert_equal('4000 E. Denny Blaine PL', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Seattle', f.contributor_city)
				assert_equal('WA', f.contributor_state)
				assert_equal('981125032', f.contributor_zip)
				assert_equal('P2002', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20020301', f.contribution_date)
				assert_equal('200.00', f.contribution_amount)
				assert_equal('300.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('TV & Ackerley Group', f.contributor_employer)
				assert_equal('Media', f.contributor_occupation)			
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
#			"SA11A1","C00256131","IND","^Morongo Bank of Mission Indians^^","PO Box 366",,"Cabazon","CA","92230    ","P2004","",,"Native American Right Fund","1000.00","20030813","1000.00","",,"","","","","","","","","","","","","","","","Con 48440","","","",""

			if schedule == "SA"				
				assert_equal('C00256131', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Morongo Bank of Mission Indians', f.contributor_first_name)
				assert_equal('PO Box 366', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Cabazon', f.contributor_city)
				assert_equal('CA', f.contributor_state)
				assert_equal('92230    ', f.contributor_zip)
				assert_equal('P2004', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20030813', f.contribution_date)
				assert_equal('1000.00', f.contribution_amount)
				assert_equal('1000.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('', f.contributor_employer)
				assert_equal('Native American Right Fund', f.contributor_occupation)			
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
		
			#"SA11ai","C00372102","IND","","PO Box 35","","Uwchland","PA","194800035","G2004","","AHB Global Services","Executive","1000","20040505","1000","","","","","","","","","","","","","","","","","","SA11ai-c2972","","","","","","Aberle","John","M.","",""

			if schedule == "SA"			
				assert_equal('C00372102', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Aberle', f.contributor_last_name)
				assert_equal('John', f.contributor_first_name)
				assert_equal('PO Box 35', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Uwchland', f.contributor_city)
				assert_equal('PA', f.contributor_state)
				assert_equal('194800035', f.contributor_zip)
				assert_equal('G2004', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20040505', f.contribution_date)
				assert_equal('1000', f.contribution_amount)
				assert_equal('1000', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('AHB Global Services', f.contributor_employer)
				assert_equal('Executive', f.contributor_occupation)			
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
		
			if schedule == "SA"			
				assert_equal('C00346114', f.committee_fecid)
				assert_equal('ORG', f.entity_type)
				assert_equal('Tuf Enterprises', f.contributor_organization_name)
				assert_equal('1 21st St', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Pittsburgh', f.contributor_city)
				assert_equal('PA', f.contributor_state)
				assert_equal('152224435', f.contributor_zip)
				assert_equal('P2006', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20050321', f.contribution_date)
				assert_equal('1000.00', f.contribution_amount)
				assert_equal('1000.00', f.contribution_aggregate)
				assert_equal('15', f.contribution_code)
				assert_equal('Receipt', f.contribution_description)	
				assert_equal('', f.contributor_employer)
				assert_equal('', f.contributor_occupation)			
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
		
			if schedule == "SA"	
						
				assert_equal('C00336065', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Acker', f.contributor_last_name)
				assert_equal('Stephen', f.contributor_first_name)
				assert_equal('1653 E Mountain St', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Pasadena', f.contributor_city)
				assert_equal('CA', f.contributor_state)
				assert_equal('91104', f.contributor_zip)
				assert_equal('P2006', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20060328', f.contribution_date)
				assert_equal('1000.00', f.contribution_amount)
				assert_equal('1000.00', f.contribution_aggregate)
				assert_equal('15', f.contribution_code)
				assert_equal('Receipt', f.contribution_description)	
				assert_equal('Acker, Kowalick & Whipple', f.contributor_employer)
				assert_equal('Attorney', f.contributor_occupation)			
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
		
			if schedule == "SA"	
						
				assert_equal('C00417501', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Aimen', f.contributor_last_name)
				assert_equal('Philip', f.contributor_first_name)
				assert_equal('113 Yale Court', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Glenview', f.contributor_city)
				assert_equal('IL', f.contributor_state)
				assert_equal('600265916', f.contributor_zip)
				assert_equal('G2008', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20080215', f.contribution_date)
				assert_equal('100.00', f.contribution_amount)
				assert_equal('400.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('Retired Attorney', f.contributor_employer)
				assert_equal('Retired Attorney', f.contributor_occupation)			
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
		
			if schedule == "SA"							
				assert_equal('C00435974', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Aiken', f.contributor_last_name)
				assert_equal('Timothy', f.contributor_first_name)
				assert_equal('3217 Brookwood Road', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Birmingham', f.contributor_city)
				assert_equal('AL', f.contributor_state)
				assert_equal('35223', f.contributor_zip)
				assert_equal('G2008', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20080602', f.contribution_date)
				assert_equal('250.00', f.contribution_amount)
				assert_equal('350.00', f.contribution_aggregate)
				assert_equal('15', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('Anesthesiologists Associated', f.contributor_employer)
				assert_equal('Anesthesiologist', f.contributor_occupation)			
				break
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
			if schedule == "SA"							
				assert_equal('C00458190', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Huddle', f.contributor_last_name)
				assert_equal('Mark', f.contributor_first_name)
				assert_equal('523 W Surf St Apt 3', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Chicago', f.contributor_city)
				assert_equal('IL', f.contributor_state)
				assert_equal('60657', f.contributor_zip)
				assert_equal('O2009', f.item_election_code)
				assert_equal('Special Primary', f.item_election_other_description)
				assert_equal('20090226', f.contribution_date)
				assert_equal('100.00', f.contribution_amount)
				assert_equal('700.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('Wildman Harrold Allen & Dixon', f.contributor_employer)
				assert_equal('Attorney', f.contributor_occupation)			
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
			if schedule == "SA"							
				
				assert_equal('C00128868', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Abromowitz', f.contributor_last_name)
				assert_equal('David', f.contributor_first_name)
				assert_equal('66 Clyde St', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Newtonville', f.contributor_city)
				assert_equal('MA', f.contributor_state)
				assert_equal('024602250', f.contributor_zip)
				assert_equal('P2010', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20090618', f.contribution_date)
				assert_equal('500.00', f.contribution_amount)
				assert_equal('500.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('Goulston & Storrs', f.contributor_employer)
				assert_equal('Attorney', f.contributor_occupation)			
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
			if schedule == "SA"							
				
				assert_equal('C00374058', f.committee_fecid)
				assert_equal('IND', f.entity_type)
				assert_equal('Warne', f.contributor_last_name)
				assert_equal('Thomas', f.contributor_first_name)
				assert_equal('70 W Cushing St', f.contributor_street_1)
				assert_equal('', f.contributor_street_2)
				assert_equal('Tucson', f.contributor_city)
				assert_equal('AZ', f.contributor_state)
				assert_equal('857012218', f.contributor_zip)
				assert_equal('P2012', f.item_election_code)
				assert_equal('', f.item_election_other_description)
				assert_equal('20110331', f.contribution_date)
				assert_equal('1200.00', f.contribution_amount)
				assert_equal('1200.00', f.contribution_aggregate)
				assert_equal('', f.contribution_code)
				assert_equal('', f.contribution_description)	
				assert_equal('J.L. Investments', f.contributor_employer)
				assert_equal('Partner', f.contributor_occupation)							
				break
			end
		end
	end		

end

Test::Unit::UI::Console::TestRunner.run(TC_FECTestScheduleA)