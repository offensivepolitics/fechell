require "rubygems"
require "fechell"
require "fechell/forms"

require 'test/unit'


require 'test/unit/ui/console/testrunner'

class TC_FECTestScheduleC < Test::Unit::TestCase
	def setup
		@testfiles = {}
		@testfiles["3.00"] = "tests/testdata/F3-3.00-32909-SC.fec"
		@testfiles["5.00"] = "tests/testdata/F3-5.00-97424-SC.fec"
		@testfiles["5.1"] = "tests/testdata/F3-5.1-126655-SC.fec"
		@testfiles["5.2"] = "tests/testdata/F3-5.2-170890-SC.fec"
		@testfiles["5.3"] = "tests/testdata/F3-5.3-212438-SC.fec"
		@testfiles["6.1"] = "tests/testdata/F3-6.1-332530-SC.fec"
		@testfiles["6.2"] = "tests/testdata/F3-6.2-350353-SC.fec"
		@testfiles["6.3"] = "tests/testdata/F3-6.3-413060-SC.fec"
		@testfiles["6.4"] = "tests/testdata/F3-6.4-420048-SC.fec"		
	end
	
	def test_v300
		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["3.00"])
		
		h.process(@testfiles["3.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
		
#SC/10,"C00353243","CAN","Mr. Sam Neill","222 Third Ave. West","","Hendersonville","NC","28739","G2002","","20000","5700","14300",20001012,"20030101",0,"N",,,,,,,"","L8"			
			if schedule == "SC"			
				assert_equal('C00353243',f.committee_fecid)
				assert_equal('L8',f.transaction_id)
				assert_equal('CAN',f.entity_type)
				assert_equal('Mr. Sam Neill',f.lender_organization_name)
				assert_equal('222 Third Ave. West',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('Hendersonville',f.lender_city)
				assert_equal('NC',f.lender_state)
				assert_equal('28739',f.lender_zip)
				assert_equal('G2002',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('20000',f.loan_amount_original)
				assert_equal('5700',f.loan_payment_to_date)
				assert_equal('14300',f.loan_balance)
				assert_equal('20001012',f.loan_incurred_date)
				assert_equal('20030101',f.loan_due_date)
				assert_equal('0',f.loan_interest_rate)
				assert_equal('N',f.loan_secured)
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
#SC/10,C00364406,CAN,FLETCHER^DEWEY LEE^^ - Personal funds ,3220 STOWERS DRIVE,,MONROE,LA,71201,P2002,,75000.00,59630.00,15370.00,20011231,on demand,0.00,N,C00364406,H2LA05068,,,,,,SC/10.4129		
			if schedule == "SC"			
				assert_equal('C00364406',f.committee_fecid)
				assert_equal('SC/10.4129',f.transaction_id)
				assert_equal('CAN',f.entity_type)
				assert_equal('FLETCHER',f.lender_last_name)
				assert_equal('DEWEY LEE',f.lender_first_name)
				assert_equal('3220 STOWERS DRIVE',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('MONROE',f.lender_city)
				assert_equal('LA',f.lender_state)
				assert_equal('71201',f.lender_zip)
				assert_equal('P2002',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('75000.00',f.loan_amount_original)
				assert_equal('59630.00',f.loan_payment_to_date)
				assert_equal('15370.00',f.loan_balance)
				assert_equal('20011231',f.loan_incurred_date)
				assert_equal('on demand',f.loan_due_date)
				assert_equal('0.00',f.loan_interest_rate)
				assert_equal('N',f.loan_secured)
				assert_equal('C00364406', f.lender_committee_fecid)
				assert_equal('H2LA05068', f.lender_candidate_fecid)
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
#SC/10,C00370197,CAN,Chavez (Personal Funds)^Jeff,5 Sommerville Place,,Ladera Ranch,CA,92694,P2002,,200.00,0.00,200.00,20011109,20041109,0.00,,,,,,,,,PAY:C:10
			if schedule == "SC"			
				assert_equal('C00370197',f.committee_fecid)
				assert_equal('PAY:C:10',f.transaction_id)
				assert_equal('CAN',f.entity_type)
				assert_equal('Chavez (Personal Funds)',f.lender_last_name)
				assert_equal('Jeff',f.lender_first_name)
				assert_equal('5 Sommerville Place',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('Ladera Ranch',f.lender_city)
				assert_equal('CA',f.lender_state)
				assert_equal('92694',f.lender_zip)
				assert_equal('P2002',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('200.00',f.loan_amount_original)
				assert_equal('0.00',f.loan_payment_to_date)
				assert_equal('200.00',f.loan_balance)
				assert_equal('20011109',f.loan_incurred_date)
				assert_equal('20041109',f.loan_due_date)
				assert_equal('0.00',f.loan_interest_rate)
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
			if schedule == "SC"
#SC/10,C00398776,CAN,Huffman^L. David^^ - Line of Credit ,PO Box 442,,Newton,NC,28658,R2004,Runoff,100000.00,0.00,100000.00,20040727,None,0,N,C00398776,,,,,,,SC/10.6301,13A			if schedule == "SC"			
				assert_equal('C00398776',f.committee_fecid)
				assert_equal('SC/10.6301',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('CAN',f.entity_type)
				assert_equal('Huffman',f.lender_last_name)
				assert_equal('L. David',f.lender_first_name)
				assert_equal('PO Box 442',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('Newton',f.lender_city)
				assert_equal('NC',f.lender_state)
				assert_equal('28658',f.lender_zip)
				assert_equal('R2004',f.election_code)
				assert_equal('Runoff',f.election_other_description)
				assert_equal('100000.00',f.loan_amount_original)
				assert_equal('0.00',f.loan_payment_to_date)
				assert_equal('100000.00',f.loan_balance)
				assert_equal('20040727',f.loan_incurred_date)
				assert_equal('None',f.loan_due_date)
				assert_equal('0',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('C00398776', f.lender_committee_fecid)
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
			if schedule == "SC"
#SC/10,C00391151,IND,GLUBA^WILLIAM E^^ - Personal funds ,2421 N GAINES STREET,,DAVENPORT,IA,52804,P2004,,65000.00,35000.00,30000.00,20031231,ON DEMAND,0,N,C00391151,H2IA01014,,,,,,SC/10.4951,13A				
				assert_equal('C00391151',f.committee_fecid)
				assert_equal('SC/10.4951',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('IND',f.entity_type)
				assert_equal('GLUBA',f.lender_last_name)
				assert_equal('WILLIAM E',f.lender_first_name)
				assert_equal('2421 N GAINES STREET',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('DAVENPORT',f.lender_city)
				assert_equal('IA',f.lender_state)
				assert_equal('52804',f.lender_zip)
				assert_equal('P2004',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('65000.00',f.loan_amount_original)
				assert_equal('35000.00',f.loan_payment_to_date)
				assert_equal('30000.00',f.loan_balance)
				assert_equal('20031231',f.loan_incurred_date)
				assert_equal('ON DEMAND',f.loan_due_date)
				assert_equal('0',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('C00391151', f.lender_committee_fecid)
				assert_equal('H2IA01014', f.lender_candidate_fecid)
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
			if schedule == "SC"
#SC/10,C00436626,L551,13A,CAN,,Turner,Michael,R.,,PERS FUNDS,16329 Hamilton Station Rd.,,Waterford,VA,20197,P2008,,25000.00,20000.00,5000.00,20070928,10/03/2012,.1375,N,,H8VA10072,Turner,Michael,R.,Mr.,,H,VA,10
				assert_equal('C00436626',f.committee_fecid)
				assert_equal('L551',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('CAN',f.entity_type)
				assert_equal('Turner',f.lender_last_name)
				assert_equal('Michael',f.lender_first_name)
				assert_equal('R.',f.lender_middle_name)
				assert_equal('16329 Hamilton Station Rd.',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('Waterford',f.lender_city)
				assert_equal('VA',f.lender_state)
				assert_equal('20197',f.lender_zip)
				assert_equal('P2008',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('25000.00',f.loan_amount_original)
				assert_equal('20000.00',f.loan_payment_to_date)
				assert_equal('5000.00',f.loan_balance)
				assert_equal('20070928',f.loan_incurred_date)
				assert_equal('10/03/2012',f.loan_due_date)
				assert_equal('.1375',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('H8VA10072', f.lender_candidate_fecid)
				assert_equal('Turner', f.lender_candidate_last_name)
				assert_equal('Michael', f.lender_candidate_first_name)
				assert_equal('R.', f.lender_candidate_middle_name)
				assert_equal('Mr.', f.lender_candidate_prefix)
				assert_equal('H', f.lender_candidate_office)
				assert_equal('VA', f.lender_candidate_state)
				assert_equal('10', f.lender_candidate_district)
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
			if schedule == "SC"
#SC/10,C00435974,SC/10.20434,13A,IND,,Harris,Andrew P.,,Dr.,,49 Montvieu Court,,Cockeysville,MD,21030,P2008,,20000.00,16500.00,3500.00,20080331,on demand,0.0000,N,Y,,,,,,,,,,,,
				assert_equal('C00435974',f.committee_fecid)
				assert_equal('SC/10.20434',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('IND',f.entity_type)
				assert_equal('Harris',f.lender_last_name)
				assert_equal('Andrew P.',f.lender_first_name)
				assert_equal('Dr.',f.lender_prefix)
				assert_equal('49 Montvieu Court',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('Cockeysville',f.lender_city)
				assert_equal('MD',f.lender_state)
				assert_equal('21030',f.lender_zip)
				assert_equal('P2008',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('20000.00',f.loan_amount_original)
				assert_equal('16500.00',f.loan_payment_to_date)
				assert_equal('3500.00',f.loan_balance)
				assert_equal('20080331',f.loan_incurred_date)
				assert_equal('on demand',f.loan_due_date)
				assert_equal('0.0000',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('Y', f.loan_personal_funds)
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
			if schedule == "SC"
#SC/10,C00434878,SC/10.6865,13A,CAN,,KRUPP,MARGARET,,,,11427 79TH PLACE,,PLEASANT PRAIRIE,WI,53158,G2008,,213.00,0.00,213.00,20081112,UPON DEMAND,0.0000,N,N,,H8WI01073,KRUPP,MARGARET,,,,H,WI,01,,
				assert_equal('C00434878',f.committee_fecid)
				assert_equal('SC/10.6865',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('CAN',f.entity_type)
				assert_equal('KRUPP',f.lender_last_name)
				assert_equal('MARGARET',f.lender_first_name)
				assert_equal('11427 79TH PLACE',f.lender_street_1)
				assert_equal('',f.lender_street_2)
				assert_equal('PLEASANT PRAIRIE',f.lender_city)
				assert_equal('WI',f.lender_state)
				assert_equal('53158',f.lender_zip)
				assert_equal('G2008',f.election_code)
				assert_equal('',f.election_other_description)
				assert_equal('213.00',f.loan_amount_original)
				assert_equal('0.00',f.loan_payment_to_date)
				assert_equal('213.00',f.loan_balance)
				assert_equal('20081112',f.loan_incurred_date)
				assert_equal('UPON DEMAND',f.loan_due_date)
				assert_equal('0.0000',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('N', f.loan_personal_funds)
	
				assert_equal('H8WI01073', f.lender_candidate_fecid)
				assert_equal('KRUPP', f.lender_candidate_last_name)
				assert_equal('MARGARET', f.lender_candidate_first_name)
				assert_equal('H', f.lender_candidate_office)
				assert_equal('WI', f.lender_candidate_state)
				assert_equal('01', f.lender_candidate_district)
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
			if schedule == "SC"
#SC/10,C00457630,L21,13A,CAN,,Forys,Victor,A.,Dr.,PERS FUNDS,834 Forestview Ave,,Park Ridge,IL,600682110,R2009,R,100000.00,0.00,100000.00,20081230,12/11/2018,.0400,N,Y,,H0IL05088,Forys,Victor,A.,Dr.,,H,IL,05,,
				assert_equal('C00457630',f.committee_fecid)
				assert_equal('L21',f.transaction_id)
				assert_equal('13A', f.receipt_line_number)
				assert_equal('CAN',f.entity_type)
				assert_equal('Forys',f.lender_last_name)
				assert_equal('Victor',f.lender_first_name)
				assert_equal('A.',f.lender_middle_name)
				assert_equal('Dr.',f.lender_prefix)
				assert_equal('834 Forestview Ave',f.lender_street_1)
				assert_equal('Park Ridge',f.lender_city)
				assert_equal('IL',f.lender_state)
				assert_equal('600682110',f.lender_zip)
				assert_equal('R2009',f.election_code)
				assert_equal('R',f.election_other_description)
				assert_equal('100000.00',f.loan_amount_original)
				assert_equal('0.00',f.loan_payment_to_date)
				assert_equal('100000.00',f.loan_balance)
				assert_equal('20081230',f.loan_incurred_date)
				assert_equal('12/11/2018',f.loan_due_date)
				assert_equal('.0400',f.loan_interest_rate)
				assert_equal('N', f.loan_secured)
				assert_equal('Y', f.loan_personal_funds)	
				assert_equal('H0IL05088', f.lender_candidate_fecid)
				assert_equal('Forys', f.lender_candidate_last_name)
				assert_equal('Victor', f.lender_candidate_first_name)
				assert_equal('A.', f.lender_candidate_middle_name)
				assert_equal('Dr.', f.lender_candidate_prefix)
				assert_equal('H', f.lender_candidate_office)
				assert_equal('IL', f.lender_candidate_state)
				assert_equal('05', f.lender_candidate_district)

				break
			end
		end
	end		
end
