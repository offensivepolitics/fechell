require "rubygems"
require "fechell"

require "fechell/forms"

require 'test/unit'


require 'test/unit/ui/console/testrunner'

class TC_FECTestScheduleC1 < Test::Unit::TestCase
	def setup
		@testfiles = {}
		@testfiles["3.00"] = "tests/testdata/F3-3.00-32564-SC1.fec"
		@testfiles["5.00"] = "tests/testdata/F3-5.00-97986-SC1.fec"
		@testfiles["5.1"] = "tests/testdata/F3-5.1-116177-SC1.fec"
		@testfiles["5.2"] = "tests/testdata/F3-5.2-171146-SC1.fec"
		@testfiles["5.3"] = "tests/testdata/F3-5.3-210142-SC1.fec"
		@testfiles["6.1"] = "tests/testdata/F3-6.1-333405-SC1.fec"
		@testfiles["6.2"] = "tests/testdata/F3-6.2-350844-SC1.fec"
		@testfiles["6.3"] = "tests/testdata/F3-6.3-413284-SC1.fec"
		@testfiles["6.4"] = "tests/testdata/F3-6.4-423088-SC1.fec"
	end
	
	def test_v300

		h = FECHell.new

		fec_version,original_form_type, form_type, values = h.header_lines(@testfiles["3.00"])
		
		h.process(@testfiles["3.00"]) do |line|
			schedule = line[0]
			values = line[1]
	
			f = FECForm.schedule_for(schedule, fec_version, values)			
			if schedule == "SC1"			
#SC1/10,C00371187,SC/10.4163,CAN,BAGLEY^DONALD DAVID JR^Mr.^Jr.,919 PINE DRIVE,,CALDWELL,TX,77836,2000.00,,20020215,,,,,,,,,0.00,,X,Personal Loan,2000.00,20020215,Bank One,303 North Market Street,,Brenham,TX,77833,,,Bagley^Jodi^Mrs.^,20020228,,,		
				assert_equal('C00371187',f.committee_fecid)
				assert_equal('SC/10.4163',f.back_reference_transaction_id)				
				assert_equal('CAN',f.entity_type)
				assert_equal('BAGLEY^DONALD DAVID JR^Mr.^Jr.',f.lender_organization_name)
				assert_equal('919 PINE DRIVE',f.lender_street_1)
				assert_equal('CALDWELL',f.lender_city)
				assert_equal('TX',f.lender_state)
				assert_equal('77836',f.lender_zip)
				assert_equal('2000.00',f.loan_amount)
				assert_equal('20020215',f.loan_incurred_date)
				#assert_equal('',f.loan_due_date)
				#assert_equal('',f.loan_interest_rate)
				#assert_equal('',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				#assert_equal('',f.credit_amount_this_draw)
				#assert_equal('',f.total_balance)
				#assert_equal('',f.others_liable)
				#assert_equal('',f.collateral)
				#assert_equal('',f.collateral_description)
				assert_equal('0.00',f.collateral_amount)
				#assert_equal('',f.perfected_interest)
				assert_equal('X',f.future_income)
				assert_equal('Personal Loan',f.future_income_description)
				assert_equal('2000.00',f.future_income_estimated_value)
				assert_equal('20020215',f.future_income_depository_account_established_date)
				assert_equal('Bank One',f.future_income_depository_account_location_name)
				assert_equal('303 North Market Street',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				assert_equal('Brenham',f.future_income_depository_account_location_city)
				assert_equal('TX',f.future_income_depository_account_location_state)
				assert_equal('77833',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Bagley',f.treasurer_last_name)
				assert_equal('Jodi',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				assert_equal('Mrs.',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20020228',f.date_signed)
				#assert_equal('',f.authorized_last_name)
				#assert_equal('',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				#assert_equal('',f.authorized_title)
				#assert_equal('',f.authorized_date_signed)
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
			if schedule == "SC1"			
#SC1/10,C00346858,SC/10.4222,CAN,Jeffrey Colyer,12711 W. 118th Street,,Overland Park,KS,66210,5000.00,7.00,20030801,20051231,,,,,,,,0.00,,,,0.00,,,,,,,,,,Bartels^Jenny^^,20031015,,,,				
				assert_equal('C00346858',f.committee_fecid)
				assert_equal('SC/10.4222',f.back_reference_transaction_id)				
				assert_equal('CAN',f.entity_type)
				assert_equal('Jeffrey Colyer',f.lender_organization_name)
				assert_equal('12711 W. 118th Street',f.lender_street_1)
				assert_equal('Overland Park',f.lender_city)
				assert_equal('KS',f.lender_state)
				assert_equal('66210',f.lender_zip)
				assert_equal('5000.00',f.loan_amount)
				assert_equal('20030801',f.loan_incurred_date)
				assert_equal('20051231',f.loan_due_date)
				assert_equal('7.00',f.loan_interest_rate)
				#assert_equal('',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				#assert_equal('',f.credit_amount_this_draw)
				#assert_equal('',f.total_balance)
				#assert_equal('',f.others_liable)
				#assert_equal('',f.collateral)
				#assert_equal('',f.collateral_description)
				assert_equal('0.00',f.collateral_amount)
				#assert_equal('',f.perfected_interest)
				#assert_equal('',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('20020215',f.future_income_depository_account_established_date)
				#assert_equal('Bank One',f.future_income_depository_account_location_name)
				#assert_equal('303 North Market Street',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Bartels',f.treasurer_last_name)
				assert_equal('Jenny',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20031015',f.date_signed)
				#assert_equal('',f.authorized_last_name)
				#assert_equal('',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				#assert_equal('',f.authorized_title)
				#assert_equal('',f.authorized_date_signed)
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
			if schedule == "SC1"			
#SC1/10,C00397612,SC/10.4169,CAN,Lewiston State Bank,37 South 200 West,,Logan,UT,84321,4000.00,5.5,20040220,,,,,,,X,Commercial Property,134000.00,X,,,0.00,,,,,,,,,,Bond^Debbie^^,20040415,,,,
				assert_equal('C00397612',f.committee_fecid)
				assert_equal('SC/10.4169',f.back_reference_transaction_id)				
				assert_equal('CAN',f.entity_type)
				assert_equal('Lewiston State Bank',f.lender_organization_name)
				assert_equal('37 South 200 West',f.lender_street_1)
				assert_equal('Logan',f.lender_city)
				assert_equal('UT',f.lender_state)
				assert_equal('84321',f.lender_zip)
				assert_equal('4000.00',f.loan_amount)
				assert_equal('20040220',f.loan_incurred_date)
				#assert_equal('',f.loan_due_date)
				assert_equal('5.5',f.loan_interest_rate)
				#assert_equal('',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				#assert_equal('',f.credit_amount_this_draw)
				#assert_equal('',f.total_balance)
				#assert_equal('',f.others_liable)
				assert_equal('X',f.collateral)
				assert_equal('Commercial Property',f.collateral_description)
				assert_equal('134000.00',f.collateral_amount)
				assert_equal('X',f.perfected_interest)
				#assert_equal('',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('20020215',f.future_income_depository_account_established_date)
				#assert_equal('Bank One',f.future_income_depository_account_location_name)
				#assert_equal('303 North Market Street',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Bond',f.treasurer_last_name)
				assert_equal('Debbie',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20040415',f.date_signed)
				#assert_equal('',f.authorized_last_name)
				#assert_equal('',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				#assert_equal('',f.authorized_title)
				#assert_equal('',f.authorized_date_signed)
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
			if schedule == "SC1"			
#SC1/10,C00392688,SC/10.6340,CAN,Bank of America,2004 San Miguel,,Austin,TX,787462017,750000.00,Floating,20040317,3/17/06,,,100000.00,750000.00,,X,Personal Property,1517000.00,X,,,0.00,,,,,,,,,,Goolsby^Kaye T.^^,20050415,,,,
				assert_equal('C00392688',f.committee_fecid)
				assert_equal('SC/10.6340',f.back_reference_transaction_id)				
				assert_equal('CAN',f.entity_type)
				assert_equal('Bank of America',f.lender_organization_name)
				assert_equal('2004 San Miguel',f.lender_street_1)
				assert_equal('Austin',f.lender_city)
				assert_equal('TX',f.lender_state)
				assert_equal('787462017',f.lender_zip)
				assert_equal('750000.00',f.loan_amount)
				assert_equal('20040317',f.loan_incurred_date)
				assert_equal('3/17/06',f.loan_due_date)
				assert_equal('Floating',f.loan_interest_rate)
				
				#assert_equal('',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				assert_equal('100000.00',f.credit_amount_this_draw)
				assert_equal('750000.00',f.total_balance)
				#assert_equal('',f.others_liable)
				assert_equal('X',f.collateral)
				assert_equal('Personal Property',f.collateral_description)
				assert_equal('1517000.00',f.collateral_amount)
				assert_equal('X',f.perfected_interest)
				#assert_equal('',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('20020215',f.future_income_depository_account_established_date)
				#assert_equal('Bank One',f.future_income_depository_account_location_name)
				#assert_equal('303 North Market Street',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Goolsby',f.treasurer_last_name)
				assert_equal('Kaye T.',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20050415',f.date_signed)
				#assert_equal('',f.authorized_last_name)
				#assert_equal('',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				#assert_equal('',f.authorized_title)
				#assert_equal('',f.authorized_date_signed)
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
			if schedule == "SC1"			
#SC1/10,C00412544,SC/10.6530,ORG,Farmers & Merchants Bank,104 North Main Street,P.O. Box  559,Sylvania,GA,30467,52678.08,8.00,20051213,12/13/06,,,,,,X,Land,52678.08,X,,,0.00,,,,,,,,,,Hunter^Emelyn^^,20060412,,,,
				assert_equal('C00412544',f.committee_fecid)
				assert_equal('SC/10.6530',f.back_reference_transaction_id)				
				assert_equal('ORG',f.entity_type)
				assert_equal('Farmers & Merchants Bank',f.lender_organization_name)
				assert_equal('104 North Main Street',f.lender_street_1)
				assert_equal('P.O. Box  559',f.lender_street_2)
				assert_equal('Sylvania',f.lender_city)
				assert_equal('GA',f.lender_state)
				assert_equal('30467',f.lender_zip)
				assert_equal('52678.08',f.loan_amount)
				assert_equal('20051213',f.loan_incurred_date)
				assert_equal('12/13/06',f.loan_due_date)
				assert_equal('8.00',f.loan_interest_rate)
				
				#assert_equal('',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				#assert_equal('',f.credit_amount_this_draw)
				#assert_equal('',f.total_balance)
				#assert_equal('',f.others_liable)
				assert_equal('X',f.collateral)
				assert_equal('Land',f.collateral_description)
				assert_equal('52678.08',f.collateral_amount)
				assert_equal('X',f.perfected_interest)
				#assert_equal('',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('',f.future_income_depository_account_established_date)
				#assert_equal('',f.future_income_depository_account_location_name)
				#assert_equal(',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Hunter',f.treasurer_last_name)
				assert_equal('Emelyn',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20060412',f.date_signed)
				#assert_equal('',f.authorized_last_name)
				#assert_equal('',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				#assert_equal('',f.authorized_title)
				#assert_equal('',f.authorized_date_signed)
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
			if schedule == "SC1"			
#SC1/10,C00439430,SC/10.5063.SC1,SC/10.5063,Commerce Bank,416 Main St,,Peoria,IL,61602,100000.00,7.67,20080121,1/22/2009,N,,100000.00,100000.00,Y,Y,Arch Development Fund 1 LLP,100000.00,Y,N,,0.00,,,,,,,,,,McCoy,Kip,Logan,,,20080415,Barr,Constance,,,,Vice President,20080121
				assert_equal('C00439430',f.committee_fecid)
				assert_equal('SC/10.5063.SC1',f.transaction_id)
				assert_equal('SC/10.5063',f.back_reference_transaction_id)				
				assert_equal('Commerce Bank',f.lender_organization_name)
				assert_equal('416 Main St',f.lender_street_1)
				#assert_equal('',f.lender_street_2)
				assert_equal('Peoria',f.lender_city)
				assert_equal('IL',f.lender_state)
				assert_equal('61602',f.lender_zip)
				assert_equal('100000.00',f.loan_amount)
				assert_equal('20080121',f.loan_incurred_date)
				assert_equal('1/22/2009',f.loan_due_date)
				assert_equal('7.67',f.loan_interest_rate)				
				assert_equal('N',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				assert_equal('100000.00',f.credit_amount_this_draw)
				assert_equal('100000.00',f.total_balance)
				assert_equal('Y',f.others_liable)
				assert_equal('Y',f.collateral)
				assert_equal('Arch Development Fund 1 LLP',f.collateral_description)
				assert_equal('100000.00',f.collateral_amount)
				assert_equal('Y',f.perfected_interest)
				assert_equal('N',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('',f.future_income_depository_account_established_date)
				#assert_equal('',f.future_income_depository_account_location_name)
				#assert_equal(',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('McCoy',f.treasurer_last_name)
				assert_equal('Kip',f.treasurer_first_name)
				assert_equal('Logan',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20080415',f.date_signed)
				assert_equal('Barr',f.authorized_last_name)
				assert_equal('Constance',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				assert_equal('Vice President',f.authorized_title)
				assert_equal('20080121',f.authorized_date_signed)
				
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
			if schedule == "SC1"			
#SC1/10,C00444919,SC/10.5274.SC1,SC/10.5274,CNB Bank,2711 Wallaceton-Bigler Road,,Bigler,PA,16825,750000.00,0.0500,20080401,n/a,N,,83000.00,198000.00,N,Y,Assignment of Investment Properties,750000.00,N,N,,0.00,,,,,,,,,,Johnston,Charles,R,,,20080715,Sloppy,Richard,,,,Loan Officer,20080709
				assert_equal('C00444919',f.committee_fecid)
				assert_equal('SC/10.5274.SC1',f.transaction_id)
				assert_equal('SC/10.5274',f.back_reference_transaction_id)				
				assert_equal('CNB Bank',f.lender_organization_name)
				assert_equal('2711 Wallaceton-Bigler Road',f.lender_street_1)
				#assert_equal('',f.lender_street_2)
				assert_equal('Bigler',f.lender_city)
				assert_equal('PA',f.lender_state)
				assert_equal('16825',f.lender_zip)
				assert_equal('750000.00',f.loan_amount)
				assert_equal('20080401',f.loan_incurred_date)
				assert_equal('n/a',f.loan_due_date)
				assert_equal('0.0500',f.loan_interest_rate)				
				assert_equal('N',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				assert_equal('83000.00',f.credit_amount_this_draw)
				assert_equal('198000.00',f.total_balance)
				assert_equal('N',f.others_liable)
				assert_equal('Y',f.collateral)
				assert_equal('Assignment of Investment Properties',f.collateral_description)
				assert_equal('750000.00',f.collateral_amount)
				assert_equal('N',f.perfected_interest)
				assert_equal('N',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				#assert_equal('',f.future_income_depository_account_established_date)
				#assert_equal('',f.future_income_depository_account_location_name)
				#assert_equal(',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('Johnston',f.treasurer_last_name)
				assert_equal('Charles',f.treasurer_first_name)
				assert_equal('R',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20080715',f.date_signed)
				assert_equal('Sloppy',f.authorized_last_name)
				assert_equal('Richard',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				assert_equal('Loan Officer',f.authorized_title)
				assert_equal('20080709',f.authorized_date_signed)			
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
			if schedule == "SC1"			
#SC1/10,C00313247,LA90415.C16726,LS90415.C16726,Traders and Farmers Bank,PO Box 550,,Haleyville,AL,35565    ,100000.00,.0360,20090331,20100331,N,20090331,0.00,0.00,N,Y,CD,100000.00,N,N,,0.00,19960207,Traders and Farmers Bank,PO Box 550,,Haleyville,AL,35565   ,,guaranteed by CD,Mobley,Jeff,,,,20090331,Whiteside,Brett,,,,Sr. V.P,20090331

				assert_equal('C00313247',f.committee_fecid)
				assert_equal('LA90415.C16726',f.transaction_id)
				assert_equal('LS90415.C16726',f.back_reference_transaction_id)				
				assert_equal('Traders and Farmers Bank',f.lender_organization_name)
				assert_equal('PO Box 550',f.lender_street_1)
				#assert_equal('',f.lender_street_2)
				assert_equal('Haleyville',f.lender_city)
				assert_equal('AL',f.lender_state)
				assert_equal('35565    ',f.lender_zip)
				assert_equal('100000.00',f.loan_amount)
				assert_equal('20090331',f.loan_incurred_date)
				assert_equal('20100331',f.loan_due_date)
				assert_equal('.0360',f.loan_interest_rate)				
				assert_equal('N',f.loan_restructured)
				assert_equal('20090331',f.loan_incurred_date_original)
				assert_equal('0.00',f.credit_amount_this_draw)
				assert_equal('0.00',f.total_balance)
				assert_equal('N',f.others_liable)
				assert_equal('Y',f.collateral)
				assert_equal('CD',f.collateral_description)
				assert_equal('100000.00',f.collateral_amount)
				assert_equal('N',f.perfected_interest)
				assert_equal('N',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				assert_equal('19960207',f.future_income_depository_account_established_date)
				assert_equal('Traders and Farmers Bank',f.future_income_depository_account_location_name)
				assert_equal('PO Box 550',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				assert_equal('Haleyville',f.future_income_depository_account_location_city)
				assert_equal('AL',f.future_income_depository_account_location_state)
				assert_equal('35565   ',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				assert_equal('guaranteed by CD',f.basis_of_loan_description)
				assert_equal('Mobley',f.treasurer_last_name)
				assert_equal('Jeff',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20090331',f.date_signed)
				assert_equal('Whiteside',f.authorized_last_name)
				assert_equal('Brett',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				assert_equal('Sr. V.P',f.authorized_title)
				assert_equal('20090331',f.authorized_date_signed)			
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
			if schedule == "SC1"			

#SC1/10,C00460436,SC/10.4214.SC1,SC/10.4214,Citibank,P.O. Box 310,,Hampstead,MD,21074,50000.00,0.0299,20090630,n/a,N,,,,N,N,,0.00,N,N,,0.00,,,,,,,,,,CLARK,CASEY,,,,20090712,CLARK,CASEY,,,,Candidate,20090630

				assert_equal('C00460436',f.committee_fecid)
				assert_equal('SC/10.4214.SC1',f.transaction_id)
				assert_equal('SC/10.4214',f.back_reference_transaction_id)				
				assert_equal('Citibank',f.lender_organization_name)
				assert_equal('P.O. Box 310',f.lender_street_1)
				#assert_equal('',f.lender_street_2)
				assert_equal('Hampstead',f.lender_city)
				assert_equal('MD',f.lender_state)
				assert_equal('21074',f.lender_zip)
				assert_equal('50000.00',f.loan_amount)
				assert_equal('20090630',f.loan_incurred_date)
				#assert_equal('',f.loan_due_date)
				assert_equal('0.0299',f.loan_interest_rate)				
				assert_equal('N',f.loan_restructured)
				#assert_equal('',f.loan_incurred_date_original)
				#assert_equal('',f.credit_amount_this_draw)
				#assert_equal('',f.total_balance)
				assert_equal('N',f.others_liable)
				assert_equal('N',f.collateral)
				#assert_equal('',f.collateral_description)
				assert_equal('0.00',f.collateral_amount)
				assert_equal('N',f.perfected_interest)
				assert_equal('N',f.future_income)
				#assert_equal('',f.future_income_description)
				assert_equal('0.00',f.future_income_estimated_value)
				assert_equal('',f.future_income_depository_account_established_date)
				#assert_equal('',f.future_income_depository_account_location_name)
				#assert_equal('',f.future_income_depository_account_location_street_1)
				#assert_equal('',f.future_income_depository_account_location_street_2)
				#assert_equal('',f.future_income_depository_account_location_city)
				#assert_equal('',f.future_income_depository_account_location_state)
				#assert_equal('',f.future_income_depository_account_location_zip)
				#assert_equal('',f.future_income_depository_account_authorization_date_presidential)
				#assert_equal('',f.basis_of_loan_description)
				assert_equal('CLARK',f.treasurer_last_name)
				assert_equal('CASEY',f.treasurer_first_name)
				#assert_equal('',f.treasurer_middle_name)
				#assert_equal('',f.treasurer_prefix)
				#assert_equal('',f.treasurer_suffix)
				assert_equal('20090712',f.date_signed)
				assert_equal('CLARK',f.authorized_last_name)
				assert_equal('CASEY',f.authorized_first_name)
				#assert_equal('',f.authorized_middle_name)
				#assert_equal('',f.authorized_prefix)
				#assert_equal('',f.authorized_suffix)
				assert_equal('Candidate',f.authorized_title)
				assert_equal('20090630',f.authorized_date_signed)			
				break
			end
		end
	end

end

Test::Unit::UI::Console::TestRunner.run(TC_FECTestScheduleC1)
