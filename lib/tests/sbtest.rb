require "rubygems"
require "fechell"

require "fechell/forms"

require 'test/unit'


require 'test/unit/ui/console/testrunner'

#				f.ordered_keys().each do |k|					
#					puts "assert_equal('',f.#{k})"
#				end					

class TC_FECTestScheduleB < Test::Unit::TestCase
	def setup
		@testfiles = {}
		@testfiles["3.00"] = "tests/testdata/F3-3.00-32933-SB.fec"
		@testfiles["5.00"] = "tests/testdata/F3-5.00-97424-SB.fec"
		@testfiles["5.1"] = "tests/testdata/F3-5.1-126655-SB.fec"
		@testfiles["5.2"] = "tests/testdata/F3-5.2-170443.fec"
		@testfiles["5.3"] = "tests/testdata/F3-5.3-210119-SB.fec"
		@testfiles["6.1"] = "tests/testdata/F3-6.1-331453-SB.fec"
		@testfiles["6.2"] = "tests/testdata/F3-6.2-350775-SB.fec"
		@testfiles["6.3"] = "tests/testdata/F3-6.3-413226-SB.fec"
		@testfiles["6.4"] = "tests/testdata/F3-6.4-424586-SB.fec"		
		@testfiles["7.0"] = "tests/testdata/F3-7.0-720829-SB.fec"
    @testfiles["8.0"] = "tests/testdata/F3-8.0-748835.fec"		
	end
	
	def test_v300
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["3.00"])
		
		h.process(@testfiles["3.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
		
			
			if schedule == "SB"			
				assert_equal('C00256131',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('Key Bank',f.payee_organization_name)
				#assert_equal('',f.payee_last_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('700 5th Avenue',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Seattle',f.payee_city)
				assert_equal('WA',f.payee_state)
				assert_equal('98104    ',f.payee_zip)
				assert_equal('P2002',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20020301',f.expenditure_date)
				assert_equal('241.64',f.expenditure_amount)
				assert_equal('001',f.expenditure_purpose_code)
				assert_equal('Bank Merchant Fee',f.expenditure_purpose_description)
				assert_equal('',f.expenditure_category_code)
				assert_equal('C00256131',f.beneficiary_committee_fecid)
				assert_equal('H2WA08075',f.beneficiary_candidate_fecid)
				assert_equal('H',f.beneficiary_candidate_office)
				assert_equal('WA',f.beneficiary_candidate_state)
				assert_equal('08',f.beneficiary_candidate_district)				
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
		
			#SB17,C00364406,IND,Capitol Vial^^^,P. O. Box 446,,Fultonville,NY,12072,,Advertising,P2004,,20030812,223.44,C00364406,,FLETCHER FOR CONGRESS,H,LA,05,,,,,,,,,,SB17.4270,,,,,004,
			if schedule == "SB"			
				assert_equal('C00364406',f.committee_fecid)
				assert_equal('IND',f.entity_type)
				#assert_equal('Key Bank',f.payee_organization_name)
				assert_equal('Capitol Vial',f.payee_last_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('P. O. Box 446',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Fultonville',f.payee_city)
				assert_equal('NY',f.payee_state)
				assert_equal('12072',f.payee_zip)
				assert_equal('P2004',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20030812',f.expenditure_date)
				assert_equal('223.44',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Advertising',f.expenditure_purpose_description)
				assert_equal('004',f.expenditure_category_code)
				assert_equal('C00364406',f.beneficiary_committee_fecid)
				#assert_equal('H2WA08075',f.beneficiary_candidate_fecid)
				assert_equal('H',f.beneficiary_candidate_office)
				assert_equal('LA',f.beneficiary_candidate_state)
				assert_equal('05',f.beneficiary_candidate_district)				
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
		
			if schedule == "SB"			
				assert_equal('C00370197',f.committee_fecid)
				assert_equal('CAN',f.entity_type)
				#assert_equal('Key Bank',f.payee_organization_name)
				#assert_equal('Capitol Vial',f.payee_organization_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('5 Sommerville Place',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Ladera Ranch',f.payee_city)
				assert_equal('CA',f.payee_state)
				assert_equal('92694',f.payee_zip)
				assert_equal('P2002',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20040301',f.expenditure_date)
				assert_equal('123.69',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Office Supplies',f.expenditure_purpose_description)
				assert_equal('',f.expenditure_category_code)
				assert_equal('',f.beneficiary_committee_fecid)
				#assert_equal('H',f.beneficiary_candidate_office)
				#assert_equal('LA',f.beneficiary_candidate_state)
				#assert_equal('05',f.beneficiary_candidate_district)				
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
		
			if schedule == "SB"			
#SB17,C00378935,ORG,,Third Avenue,,New York,NY,10022,,Bank Charge,P2006,,20050103,20.00,C00378935,,FRIENDS OF ANTON SRDANOVIC,H,NY,14,,,,,,,,,,SB17.4679,,,,,,,Chase Bank,,,,,
				assert_equal('C00378935',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				#assert_equal('Key Bank',f.payee_organization_name)
				#assert_equal('Capitol Vial',f.payee_organization_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('Third Avenue',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('New York',f.payee_city)
				assert_equal('NY',f.payee_state)
				assert_equal('10022',f.payee_zip)
				assert_equal('P2006',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20050103',f.expenditure_date)
				assert_equal('20.00',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Bank Charge',f.expenditure_purpose_description)
				assert_equal('',f.expenditure_category_code)
				assert_equal('C00378935',f.beneficiary_committee_fecid)
				assert_equal('H',f.beneficiary_candidate_office)
				assert_equal('NY',f.beneficiary_candidate_state)
				assert_equal('14',f.beneficiary_candidate_district)				
				## 5.1-5.3 only for individuals / orgs
				assert_equal('Chase Bank', f.recipient_organization_name)
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
		
			if schedule == "SB"			
#SB17,C00414391,IND,,RD 2 Box 359,,Ulster,PA,18850,,In-kind - office expenses & phone,P2006,,20051015,308.11,,,,,,,,,,,,,,,,SB17.4668,,,,,,,,Eldredge-Martin,Andrew,,,
				assert_equal('C00414391',f.committee_fecid)
				assert_equal('IND',f.entity_type)
				#assert_equal('Key Bank',f.payee_organization_name)
				#assert_equal('Capitol Vial',f.payee_organization_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('RD 2 Box 359',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Ulster',f.payee_city)
				assert_equal('PA',f.payee_state)
				assert_equal('18850',f.payee_zip)
				assert_equal('P2006',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20051015',f.expenditure_date)
				assert_equal('308.11',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('In-kind - office expenses & phone',f.expenditure_purpose_description)
				assert_equal('',f.expenditure_category_code)
				## 5.1-5.3 only for individuals / orgs
				assert_equal('Eldredge-Martin', f.recipient_last_name)
				assert_equal('Andrew', f.recipient_first_name)
				#assert_equal('C00378935',f.beneficiary_committee_fecid)
				#assert_equal('H',f.beneficiary_candidate_office)
				#assert_equal('NY',f.beneficiary_candidate_state)
				#assert_equal('14',f.beneficiary_candidate_district)				
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
		
			if schedule == "SB"			
#SB17C00390476SB17.34826ORGAdvantage Printing2717 N PerrySpokaneWA99207P2008200803089920.00Advertising - 1800 yard signs004				
				assert_equal('C00390476',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('Advantage Printing',f.payee_organization_name)
				#assert_equal('',f.payee_first_name)
				#assert_equal('',f.payee_middle_name)
				#assert_equal('',f.payee_prefix)
				#assert_equal('',f.payee_suffix)
				assert_equal('2717 N Perry',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Spokane',f.payee_city)
				assert_equal('WA',f.payee_state)
				assert_equal('99207',f.payee_zip)
				assert_equal('P2008',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20080308',f.expenditure_date)
				assert_equal('9920.00',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Advertising - 1800 yard signs',f.expenditure_purpose_description)
				assert_equal('004',f.expenditure_category_code)
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
		
			if schedule == "SB"			
#SB17C0031053280507.E8753ORGOffice Depot401 Carroll StreetFort WorthTX76107    20080401151.53Office SuppliesXMEMO: OFFICE SUPPLIES				
				assert_equal('C00310532',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('Office Depot',f.payee_organization_name)
				assert_equal('401 Carroll Street',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Fort Worth',f.payee_city)
				assert_equal('TX',f.payee_state)
				assert_equal('76107    ',f.payee_zip)
				assert_equal('',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20080401',f.expenditure_date)
				assert_equal('151.53',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Office Supplies',f.expenditure_purpose_description)
				assert_equal('',f.expenditure_category_code)
				assert_equal('X', f.memo_code)
				assert_equal("MEMO: OFFICE SUPPLIES", f.memo_text)
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
		
			if schedule == "SB"			
#SB17C00372102B-E-21820ORGPaychex, Inc1100 Adams AvenueNorristownPA194032404P201020090206155.91Employers Payroll Tax001
				assert_equal('C00372102',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('Paychex, Inc',f.payee_organization_name)
				assert_equal('1100 Adams Avenue',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Norristown',f.payee_city)
				assert_equal('PA',f.payee_state)
				assert_equal('194032404',f.payee_zip)
				assert_equal('P2010',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20090206',f.expenditure_date)
				assert_equal('155.91',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Employers Payroll Tax',f.expenditure_purpose_description)
				assert_equal('001',f.expenditure_category_code)
				assert_equal('', f.memo_code)
				assert_equal("", f.memo_text)
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
		
			if schedule == "SB"		
						
#SB17C0044370517-3809ORGPublic Storage1761 Adrian RdBurlingameCA94010200906171083.000.00Storage Fees001
				assert_equal('C00443705',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('Public Storage',f.payee_organization_name)
				assert_equal('1761 Adrian Rd',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Burlingame',f.payee_city)
				assert_equal('CA',f.payee_state)
				assert_equal('94010',f.payee_zip)
				assert_equal('',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20090617',f.expenditure_date)
				assert_equal('1083.00',f.expenditure_amount)
				assert_equal('0.00',f.expenditure_purpose_code)
				assert_equal('Storage Fees',f.expenditure_category_code)
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
		
			if schedule == "SB"		
						
				assert_equal('C00462721',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('AT&T Mobility',f.payee_organization_name)
				assert_equal('PO BOX 30218',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Los Angeles',f.payee_city)
				assert_equal('CA',f.payee_state)
				assert_equal('900300218',f.payee_zip)
				assert_equal('P2010',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20110315',f.expenditure_date)
				assert_equal('400.00',f.expenditure_amount)
				assert_equal('',f.expenditure_purpose_code)
				assert_equal('Paid off debt',f.expenditure_category_code)
				break
			end
		end
	end
	
	def test_v8
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["8.0"])
		
		h.process(@testfiles["8.0"]) do |line|
			schedule = line[0]
			values = line[1]

			f = FECForm.schedule_for(schedule, fec_version, values)			
		
			if schedule == "SB"		
						
				assert_equal('C00374058',f.committee_fecid)
				assert_equal('ORG',f.entity_type)
				assert_equal('National Democratic Club',f.payee_organization_name)
				assert_equal('30 Ivy St SE',f.payee_street_1)
				assert_equal('',f.payee_street_2)
				assert_equal('Washington',f.payee_city)
				assert_equal('DC',f.payee_state)
				assert_equal('200034006',f.payee_zip)
				assert_equal('P2012',f.item_election_code)
				assert_equal('',f.item_election_other_description)
				assert_equal('20110909',f.expenditure_date)
				assert_equal('2308.66',f.expenditure_amount)
				assert_equal('Catering',f.expenditure_category_code)
				break
			end
		end
  end


end

Test::Unit::UI::Console::TestRunner.run(TC_FECTestScheduleB)