# F3 filings (done):
#  -SA{line number}: 'SA11AI', 'SA11B', 'SA11C', 'SA11D', 'SA12','SA13A', 'SA13B', 'SA14', 'SA15'
#  -SB{line number}: 'SB17', 'SB18', 'SB19A', 'SB19B', 'SB20A', 'SB20B','SB20C', 'SB21'
#  -SC{line number}:  'SC/9', 'SC/10'
#  -SC1{line number}: 'SC1/9', 'SC1/10'
#  -SC2{line number}: 'SC2/9', 'SC2/10'
#  -SD{line number}:  'SD9', 'SD10'

# F3X filing (F3X not done)
#  -SA  + [11AI; 11B; 11C; 12; 13; 14; 15; 16; 17; 18; SI1; SL1A; SL2] 
#  -SB  + [21B; 22; 23; 26; 27; 28A; 28B; 28C; 29; SI2; SI3; SI4; SI5; SL4A; SL4B; SL4C; SL4D; SL5] 
#  -SC  + [/9; /10] 
#  -SC1 + [/9; /10] 
#  -SC2 + [/9; /10] 
#  -SD  + [9; 10] 
#  -SE 
#  -SF 
#  H1  
#  H2  
#  H3  
#  H4 
#  H5  {new BCRA form} 
#  H6  {new BCRA form} 
#  SI 
#  SL  {new BCRA form} 

# F24
#  SE

class FECForm

	attr_reader :schedule
	attr_reader :version	
	attr_reader :values		

	@@schedules = {}
	
	def initialize(schedule, version)
		
		@schedule = schedule
		@version = version
		@values = {}
		@allkeys = []
		@data = {}
		@options = {}
		
		field(:form_type, ["8.0","7.0", "6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "FORM TYPE", {:force_upper => true})
	end						
	
	def field(key, fversion, value,options = {} )			
		@values[namespaced(key)] ||= {}

		@options[namespaced(key)] ||= {}

		@outdata = {}
				
		[fversion].flatten.each do |fec_version|
			@values[namespaced(key)][fec_version] = value
			@options[namespaced(key)][fec_version] = options
		end

		@allkeys << key

		@allkeys.uniq!

	end		

	def parse(line)
		# load the data		
		line.each do |k,v|	
			@data[k] = v
		end
		
		# loop through the keys and apply any options
		
		@allkeys.each do |key|
			dirty = false
			keyoptions = @options[namespaced(key)][@version] || {}
			value = @data[@values[namespaced(key)][@version]]
		
			@outdata[namespaced(key)] ||= {}
			
			if keyoptions[:default].nil? == false
				value = keyoptions[:default]
			end
			
			next if value.nil? == true
			
			if keyoptions[:force_upper] == true				
				value = value.to_s.upcase
			elsif keyoptions[:split] == true
				splitchar = keyoptions[:split_char] || '^'
				splitindex = keyoptions[:split_index] || 0
				
				parts = value.split(splitchar)
				if parts.length < splitindex
					value = ''
				else
					value = parts[splitindex]
				end
			end
			@outdata[namespaced(key)][@version] = value
		end

	end

	def ordered_keys()		
		@allkeys
	end
	
	def as_hash()
		h = {}
		@allkeys.each do |key|
			h[key] = @outdata[namespaced(key)][@version]
		end
		h
	end
		
	def method_missing(id, *args)		
		return send(id) if respond_to?(id)
		return @outdata[namespaced(id)][@version] || "" if @allkeys.index(id).nil? == false			
		raise NoMethodError
	end
	
	def as_activerecord(model)
		ar = model.send(:new, as_hash())
		ar
	end
		
	def self.register(schedule_name, class_name)
		@@schedules ||= {}
		@@schedules[schedule_name] = class_name		
	end
	
	def self.schedule_for(schedule,version,values)
		f = @@schedules[schedule.to_sym].send(:new, schedule,version)				
		f.parse(values)
		f		
	end
	
	def self.available_schedules
		@@schedules.keys
	end

	private
	def namespaced(k)
		"fechell_#{k.to_s}".to_sym
	end
	

end

class Form24 < FECForm
	register(:F24, Form24)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		
	end
end

class Form3 < FECForm
	
	register(:F3, Form3)
	
	def initialize(schedule, version)
		super(schedule, version)			
		
		#field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		#field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")
	
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "FILER COMMITTEE ID NUMBER")
		
		field(:committee_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "COMMITTEE NAME")
		
		#field(:change_of_address, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CHG OF ADDRESS")
		#field(:change_of_address, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CHANGE OF ADDRESS")
		field(:change_of_address, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CHANGE OF ADDRESS")
		
		field(:street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "STREET 1")
		field(:street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "STREET 2")
		field(:city, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")
		field(:state, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")			
		field(:zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")
		
		field(:election_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ELECTION STATE")			
		field(:election_district, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ELECTION DISTRICT")
		
		#field(:report_code,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "REPORT CODE" )
		#field(:report_code,["5.3", "5.2", "5.1", "5.00", "3.00"], "RPTCODE" )
		field(:report_code,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "REPORT CODE" )
		
		#field(:election_code,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION CODE  {was RPTPGI}" )
		#field(:election_code,["5.3", "5.2", "5.1", "5.00", "3.00"], "RPTPGI" )
		field(:election_code,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ELECTION CODE" )
		
		#field(:date_of_election,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DATE OF ELECTION")
		#field(:date_of_election,["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Of Election)")
		
		field(:date_of_election,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "DATE OF ELECTION")
		
		#field(:state_of_election,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "STATE OF ELECTION")
		#field(:state_of_election,["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE (Of Election)")
		field(:state_of_election,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "STATE OF ELECTION")
		
		#field(:date_from_coverage,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COVERAGE FROM DATE")
		#field(:date_from_coverage,["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Coverage From)")
		field(:date_from_coverage,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "COVERAGE FROM DATE")
	
		#field(:date_through_coverage,["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COVERAGE THROUGH DATE")
		#field(:date_through_coverage,["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Coverage To)")
		
		field(:date_through_coverage,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "COVERAGE THROUGH DATE")
	
		
		field(:date_signed,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"],"DATE SIGNED" )
	
		field(:col_A_line_6a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (6a) Total Contributions (NO Loans)")			
		field(:col_A_line_6b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (6b) Total Contribution Refunds")
		field(:col_A_line_6c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (6c) Net Contributions")
	
		field(:col_A_line_7a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (7a) Total Operating Expenditures")
		field(:col_A_line_7b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (7b) Total Offset to Operating Expenditures")
		field(:col_A_line_7c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A (7c) NET Operating Expenditures.")
	
		field(:col_A_line_8, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 8. CASH ON HAND AT CLOSE ...")
	
		field(:col_A_line_9, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 9. DEBTS TO ( Totals from SCH C and/or D)")
	
		field(:col_A_line_10, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 10. DEBTS BY (Totals from SCH C and/or D)")
	
		field(:col_A_line_11ai, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(a i.) Individuals Itemized")
		field(:col_A_line_11aii, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(a.ii) Individuals Unitemized")
		field(:col_A_line_11aii, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(a.ii) Individuals Unitemized")
		field(:col_A_line_11aiii, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(a.iii) Individual Contribution Total")
	
		field(:col_A_line_11b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(b) Political Party Committees")
		field(:col_A_line_11c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(c) Other Political Committees")
		field(:col_A_line_11d, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(d) The Candidate")
		field(:col_A_line_11e, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 11(e) Total Contributions")
	
		field(:col_A_line_12, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 12. Transfers From Other Authorized Cmttes")
	
		field(:col_A_line_13a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 13(a) Loans made or guarn. by the Candidate")
		field(:col_A_line_13b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 13(b) All Other Loans")
		field(:col_A_line_13c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 13(c) Total Loans")
	
		field(:col_A_line_14, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 14. Offsets to Operating Expenditures")
	
		field(:col_A_line_15, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 15. Other Receipts")
	
		field(:col_A_line_16, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 16. Total Receipts")
	
		field(:col_A_line_17, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 17. Operating Expenditures")
	
		field(:col_A_line_18, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 18. Transfers to Other Authorized Committees")
	
		field(:col_A_line_19a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 19(a) Of Loans made or guar. by the Cand.")
		field(:col_A_line_19b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 19(b) Loan Repayments, All Other Loans")
		field(:col_A_line_19c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 19(c) Total Loan Repayments")
	
		field(:col_A_line_20a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 20(a) Refund/Individuals Other than Pol. Cmtes")
		field(:col_A_line_20b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 20(b) Refund/Political Party Committees")
		field(:col_A_line_20c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 20(c) Refund/Other Political Committees")
		field(:col_A_line_20d, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 20(d) Total Contribution Refunds")
	
		field(:col_A_line_21, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 21. Other Disbursements")
	
		field(:col_A_line_22, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 22. Total Disbursements")
	
		field(:col_A_line_23, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 23. Cash Beginning Reporting Period")
	
		field(:col_A_line_24, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 24. Total Receipts this Period")
	
		field(:col_A_line_25, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 25. SubTotal")
	
		field(:col_A_line_26, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 26. Total Disbursements this Period")
	
		field(:col_A_line_27, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column A 27. Cash on hand at Close Period")
	
		field(:col_B_line_6a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (6a) Total Contributions (NO Loans)")			
		field(:col_B_line_6b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (6b) Total Contribution Refunds")
		field(:col_B_line_6c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (6c) Net Contributions")
	
		field(:col_B_line_7a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (7a) Total Operating Expenditures")
		field(:col_B_line_7b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (7b) Total Offsets to Operating Expenditures")
		field(:col_B_line_7c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B (7c) NET Operating Expenditures.")
	
		#field(:col_B_line_11ai, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "Column B 11(a i) Individuals Itemized")
		#field(:col_B_line_11ai, ["5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(a i.) Individuals Itemized")
		field(:col_B_line_11ai, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(a.i) Individuals Itemized")
		
		field(:col_B_line_11aii, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(a.ii) Individuals Unitemized")
		field(:col_B_line_11aiii, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(a.iii) Individual Contribution Total")
	
		field(:col_B_line_11b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(b) Political Party Committees")
		field(:col_B_line_11c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(c) All Other Political Committees (PACS)")
		field(:col_B_line_11d, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(d) The Candidate")
		field(:col_B_line_11e, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 11(e) Total Contributions")
	
		field(:col_B_line_12, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 12. Transfers From Other AUTH Committees")
	
		field(:col_B_line_13a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 13(a) Loans made or guarn. by the Candidate")
		field(:col_B_line_13b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 13(b) All Other Loans")
		field(:col_B_line_13c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 13(c) Total Loans")
	
		field(:col_B_line_14, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 14. Offsets to Operating Expenditures")
	
		field(:col_B_line_15, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 15. Other Receipts")
	
		field(:col_B_line_16, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 16. Total Receipts")
	
		field(:col_B_line_17, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 17 Operating Expenditures")
	
		field(:col_B_line_18, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 18. Transfers To Other AUTH Committees")
	
		field(:col_B_line_19a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 19(a) Loan Repayment By Candidate")
		field(:col_B_line_19b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 19(b) Loan Repayments, All Other Loans")
		field(:col_B_line_19c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 19(c) Total Loan Repayments")
	
		field(:col_B_line_20a, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 20(a) Refund/Individuals Other than Pol. Cmtes")
		field(:col_B_line_20b, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 20(b) Refund, Political Party Committees")
		field(:col_B_line_20c, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 20(c) Refund, Other Political Committees")
		field(:col_B_line_20d, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 20(d) Total Contributions Refunds")
	
		field(:col_B_line_21, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 21. Other Disbursements")
	
		field(:col_B_line_22, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Column B 22. Total Disbursements")	
		
				

	end		
end

class ScheduleA < FECForm
	
	register(:SA, ScheduleA)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")
		
		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")
		
		field(:back_reference_schedule, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE SCHED NAME")
		field(:back_reference_schedule, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF SCHED NAME")
		
		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")	
		
		field(:contributor_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR ORGANIZATION NAME")
		field(:contributor_organization_name, ["5.3", "5.2", "5.1"], "CONTRIB ORGANIZATION NAME")
		field(:contributor_organization_name, ["5.00","3.00"], "CONTRIBUTOR NAME")
		
		field(:contributor_last_name, ["8.0","7.0","6.4","6.3", "6.2","6.1"], "CONTRIBUTOR LAST NAME")
		field(:contributor_last_name, ["5.3", "5.2", "5.1"], "CONTRIBUTOR LAST NAME")
		field(:contributor_last_name, ["5.00","3.00"], "CONTRIBUTOR NAME",{:split => true, :split_char => '^', :split_index => 0})
		
		field(:contributor_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR FIRST NAME")
		field(:contributor_first_name, ["5.3", "5.2", "5.1"], "CONTRIBUTOR FIRST NAME")
		field(:contributor_first_name, ["5.00","3.00"], "CONTRIBUTOR NAME",{:split => true, :split_char => '^', :split_index => 1})
		
		
		field(:contributor_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CONTRIBUTOR MIDDLE NAME")
		field(:contributor_middle_name, ["5.00","3.00"], " CONTRIBUTOR NAME")
		
		field(:contributor_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CONTRIBUTOR PREFIX")
		field(:contributor_prefix, ["5.00","3.00"], " CONTRIBUTOR NAME")
		
		field(:contributor_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CONTRIBUTOR SUFFIX")
		field(:contributor_suffix, ["5.00","3.00"], " CONTRIBUTOR NAME")
		
		field(:contributor_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR STREET  1")
		field(:contributor_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")
		
		field(:contributor_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR STREET  2")
		field(:contributor_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")
		
		field(:contributor_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR CITY")
		field(:contributor_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")
		
		field(:contributor_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR STATE")
		field(:contributor_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")
		
		field(:contributor_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR ZIP")
		field(:contributor_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")
		
		field(:item_election_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION CODE")
		field(:item_election_code, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ITEM ELECT CD")
		
		field(:item_election_other_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION OTHER DESCRIPTION")
		field(:item_election_other_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ITEM ELECT OTHER")
		
		field(:contribution_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTION DATE")
		field(:contribution_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE RECEIVED")
		
		
		field(:contribution_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTION AMOUNT")
		field(:contribution_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMOUNT RECEIVED")
		
		field(:contribution_aggregate, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTION AGGREGATE")
		field(:contribution_aggregate, ["5.3","5.2"], "AGGREGATE AMT TO DATE")
		field(:contribution_aggregate, ["5.1", "5.00", "3.00"], "AGGREGATE AMT Y-T-D")
		
		field(:contribution_code, ["7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTION PURPOSE CODE")
		field(:contribution_code, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRANS CODE")
		
		field(:contribution_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTION PURPOSE DESCRIP")
		field(:contribution_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRANS DESCRIP")
		
		
		field(:contributor_employer, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR EMPLOYER")
		field(:contributor_employer, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INDEMP")
		
		field(:contributor_occupation, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CONTRIBUTOR OCCUPATION")
		field(:contributor_occupation, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INDOCC")
		
		field(:donor_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR COMMITTEE FEC ID")
		field(:donor_committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FEC COMMITTEE ID NUMBER")
		
		field(:donor_committee_name, ["8.0","7.0","6.4","6.3", "6.2"], "DONOR COMMITTEE NAME")
		
		field(:donor_candidate_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE FEC ID")
		field(:donor_candidate_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FEC CANDIDATE ID NUMBER")
		
		
		field(:donor_candidate_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE LAST NAME")
		field(:donor_candidate_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")
		
		field(:donor_candidate_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE FIRST NAME")
		field(:donor_candidate_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")
		
		field(:donor_candidate_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE FIRST NAME")
		field(:donor_candidate_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")
		
		field(:donor_candidate_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE PREFIX")
		field(:donor_candidate_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")
		
		field(:donor_candidate_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE SUFFIX")
		field(:donor_candidate_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")
		
		field(:donor_candidate_office, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE OFFICE")
		field(:donor_candidate_office, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/OFFICE")
		
		field(:donor_candidate_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE STATE ")
		field(:donor_candidate_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/STATE")
		
		field(:donor_candidate_district, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DONOR CANDIDATE DISTRICT")
		field(:donor_candidate_district, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/DIST")
		
		field(:conduit_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT NAME")	
		field(:conduit_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STREET1")	
		field(:conduit_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STREET2")	
		field(:conduit_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT CITY")	
		field(:conduit_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STATE")	
		field(:conduit_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT ZIP")	
		
		field(:memo_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO CODE")	
		
		field(:memo_text, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "MEMO TEXT/DESCRIPTION")
		field(:memo_text, ["5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO TEXT")
		
		field(:increased_limit_code, ["6.3", "6.2", "6.1"], "INCREASED LIMIT CODE")
		field(:increased_limit_code, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INCREASED LIMIT")
		
		field(:SI_SL_account_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Reference to SI or SL system code that identifies the Account")	
	end
	
end

class ScheduleB < FECForm
	
	register(:SB, ScheduleB)
	
	def initialize(schedule, version)		
		super(schedule, version)

		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")


		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")

		field(:back_reference_schedule, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE SCHED NAME")
		field(:back_reference_schedule, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF SCHED NAME")

		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")	

		field(:payee_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ORGANIZATION NAME")
		field(:payee_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME")

		field(:payee_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE LAST NAME")
		field(:payee_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME", {:split => true, :split_index => 0})

		field(:payee_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE FIRST NAME")
		field(:payee_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME",{:split => true, :split_index => 1})

		field(:payee_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE MIDDLE NAME")
		field(:payee_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME")

		field(:payee_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE PREFIX")
		field(:payee_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME")

		field(:payee_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE SUFFIX")
		field(:payee_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "RECIPIENT NAME")

		field(:payee_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  1")
		field(:payee_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:payee_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  2")
		field(:payee_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:payee_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CITY")
		field(:payee_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:payee_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STATE")
		field(:payee_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:payee_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ZIP")
		field(:payee_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")

		field(:item_election_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION CODE")
		field(:item_election_code, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ITEM ELECT CD")

		field(:item_election_other_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION OTHER DESCRIPTION")
		field(:item_election_other_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ITEM ELECT OTHER")


		field(:expenditure_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE DATE")
		field(:expenditure_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE OF EXPENDITURE")

		field(:expenditure_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE AMOUNT")
		field(:expenditure_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMOUNT OF EXPENDITURE")

		field(:expenditure_purpose_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE CODE")
		field(:expenditure_purpose_code, ["5.3", "5.2", "5.1", "5.00"], "TRANS {Purpose} CODE")
		field(:expenditure_purpose_code, ["3.00"], "TRANS CODE")

		field(:expenditure_purpose_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE DESCRIP")
		field(:expenditure_purpose_description, ["5.3", "5.2", "5.1", "5.00"], "TRANS {Purpose} DESCRIP")
		field(:expenditure_purpose_description, ["3.00"], "TRANS DESCRIP")


		field(:expenditure_category_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CATEGORY CODE")

		field(:beneficiary_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2"], "BENEFICIARY COMMITTEE FEC ID")
		field(:beneficiary_committee_fecid, ["6.1","5.3", "5.2", "5.1", "5.00","3.00"], "FEC COMMITTEE ID NUMBER")

		field(:beneficiary_candidate_fecid, ["8.0","7.0","6.4","6.3", "6.2"], "BENEFICIARY CANDIDATE FEC ID")
		field(:beneficiary_candidate_fecid, ["6.1","5.3", "5.2", "5.1", "5.00","3.00"], "FEC CANDIDATE ID NUMBER")

		field(:beneficiary_candidate_office, ["8.0","7.0","6.4","6.3", "6.2"], "BENEFICIARY CANDIDATE OFFICE")
		field(:beneficiary_candidate_office, ["6.1"],"PAYEE CANDIDATE OFFICE")
		field(:beneficiary_candidate_office, ["5.3", "5.2", "5.1", "5.00","3.00"], "CAN/OFFICE")

		field(:beneficiary_candidate_state, ["8.0","7.0","6.4","6.3", "6.2"], "BENEFICIARY CANDIDATE STATE")
		field(:beneficiary_candidate_state, ["6.1"],"PAYEE CANDIDATE STATE ")
		field(:beneficiary_candidate_state, ["5.3", "5.2", "5.1", "5.00","3.00"], "CAN/STATE   ")

		field(:beneficiary_candidate_district, ["8.0","7.0","6.4","6.3", "6.2"], "BENEFICIARY CANDIDATE DISTRICT")
		field(:beneficiary_candidate_district, ["6.1"],"PAYEE CANDIDATE DISTRICT")
		field(:beneficiary_candidate_district, ["5.3", "5.2", "5.1", "5.00","3.00"], "CAN/DIST")


		field(:conduit_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT NAME")	
		field(:conduit_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STREET1")	
		field(:conduit_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STREET2")	
		field(:conduit_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT CITY")	
		field(:conduit_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT STATE")	
		field(:conduit_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "CONDUIT ZIP")	

		field(:memo_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO CODE")	

		field(:memo_text, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "MEMO TEXT/DESCRIPTION")
		field(:memo_text, ["5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO TEXT")
		
		field(:recipient_organization_name,  ["5.3", "5.2", "5.1"], "RECIPIENT ORGANIZATION NAME")
		field(:recipient_last_name,  ["5.3", "5.2", "5.1"], "RECIPIENT LAST NAME")
		field(:recipient_first_name,  ["5.3", "5.2", "5.1"], "RECIPIENT FIRST NAME")
		field(:recipient_middle_name,  ["5.3", "5.2", "5.1"], "RECIPIENT MIDDLE NAME")
		field(:recipient_prefix,  ["5.3", "5.2", "5.1"], "RECIPIENT PREFIX")
		field(:recipient_suffix,  ["5.3", "5.2", "5.1"], "RECIPIENT SUFFIX")
	end
end

class FileHeader < FECForm
	
	register(:HDR, FileHeader)
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:HDR,  ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "HDR")
		field(:form_type,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "FORM TYPE")
		field(:fec_tag,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "FEC TAG")
		field(:fec_file_version,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "FEC File Version")
		field(:filing_software_name,["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Filing Software Name")
		field(:filing_software_version, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Filing Software Version")		
		field(:report_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Report ID")
		field(:report_number, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "Report Number")
	end
end

class ScheduleC < FECForm
	register(:SC, ScheduleC)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")

		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:receipt_line_number, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1"], "RECEIPT LINE NUMBER")

		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")


		field(:lender_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER ORGANIZATION NAME")
		field(:lender_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)")

		field(:lender_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER LAST NAME")
		field(:lender_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)",{:split => true, :split_index => 0})

		field(:lender_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER FIRST NAME")
		field(:lender_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)",{:split => true, :split_index => 1})

		field(:lender_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER MIDDLE NAME")
		field(:lender_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)",{:split => true, :split_index => 100})

		field(:lender_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER PREFIX")
		field(:lender_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)",{:split => true, :split_index => 2})

		field(:lender_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER SUFFIX")
		field(:lender_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)",{:split => true, :split_index => 100})

		field(:lender_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET  1")
		field(:lender_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:lender_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET  2")
		field(:lender_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:lender_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CITY")
		field(:lender_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:lender_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STATE")
		field(:lender_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:lender_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER ZIP")
		field(:lender_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")

		field(:election_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION CODE")
		field(:election_code, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ELECTION ")

		field(:election_other_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION OTHER DESCRIPTION")
		field(:election_other_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ELECTION DESCRIPTION")

		field(:loan_amount_original, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN AMOUNT (Original)")
		field(:loan_amount_original, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ORIG. AMT OF LOAN")

		field(:loan_payment_to_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN PAYMENT TO DATE")
		field(:loan_payment_to_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "PAYMENT TO DATE")

		field(:loan_balance, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "LOAN BALANCE")

		field(:loan_incurred_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN INCURRED DATE (Terms)")
		field(:loan_incurred_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Incurred)")

		field(:loan_due_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN DUE DATE (Terms)")
		field(:loan_due_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DUE DATE TERMS")

		field(:loan_interest_rate, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN INTEREST RATE % (Terms)")
		field(:loan_interest_rate, ["5.3", "5.2", "5.1", "5.00", "3.00"], "PCT RATE TERMS")

		field(:loan_secured, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "YES/NO (Secured?)")
		field(:loan_secured, ["5.3", "5.2", "5.1", "5.00", "3.00"], "SECURED YESNO")
	
		field(:loan_personal_funds, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "YES/NO (Personal Funds)")


		field(:lender_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER COMMITTEE ID NUMBER")
		field(:lender_committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FEC COMMITTEE ID NUMBER")

		field(:lender_candidate_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE ID NUMBER")
		field(:lender_candidate_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FEC CANDIDATE ID NUMBER")


		field(:lender_candidate_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE LAST NAME")
		field(:lender_candidate_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:lender_candidate_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE FIRST NAME")
		field(:lender_candidate_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:lender_candidate_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE MIDDLE NM")
		field(:lender_candidate_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:lender_candidate_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE PREFIX")
		field(:lender_candidate_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:lender_candidate_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE SUFFIX")
		field(:lender_candidate_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")


		field(:lender_candidate_office, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE OFFICE")
		field(:lender_candidate_office, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/OFFICE")

		field(:lender_candidate_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE STATE")
		field(:lender_candidate_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/STATE ")

		field(:lender_candidate_district, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CANDIDATE DISTRICT")
		field(:lender_candidate_district, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/DIST")

		field(:memo_code, ["8.0","7.0","6.4","6.3", "6.2"], "MEMO CODE")	
		field(:memo_text, ["5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO TEXT/DESCRIPTION")
	end
end

class ScheduleC1 < FECForm
	
	register(:SC1, ScheduleC1)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")

		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3","5.2", "5.1","5.00","3.00"], "BACK REFERENCE TRAN ID")

		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")

		field(:lender_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER ORGANIZATION NAME")
		field(:lender_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Loan Source)")

		field(:lender_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET  1")
		field(:lender_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:lender_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET  2")
		field(:lender_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:lender_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CITY")
		field(:lender_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:lender_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STATE")
		field(:lender_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:lender_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER ZIP")
		field(:lender_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")

		field(:loan_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN AMOUNT")
		field(:loan_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMT OF LOAN")

		field(:loan_incurred_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN INCURRED DATE")
		field(:loan_incurred_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Incurred)")

		field(:loan_due_date, ["6.4"], "LOAN DUE DATE (Terms)")
		field(:loan_due_date, ["6.3","6.2","6.1"], "LOAN DUE DATE")		
		field(:loan_due_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE  (Due)")

		field(:loan_interest_rate, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LOAN INTEREST RATE %")
		field(:loan_interest_rate, ["5.3", "5.2", "5.1", "5.00", "3.00"], "LOAN INTEREST RATE PERCENT")

		field(:loan_restructured, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "A1.YES/NO (Loan Restructured?)")
		field(:loan_restructured, ["5.3", "5.2", "5.1", "5.00", "3.00"], "A1.YESNO (Loan Restructured)")

		field(:loan_incurred_date_original, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "A2. LOAN INCCURED DATE (Original)")
		field(:loan_incurred_date_original, ["5.3", "5.2", "5.1", "5.00", "3.00"], "A2. DATE (Of Original Loan)")
	
		field(:credit_amount_this_draw, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "B.1. CREDIT AMOUNT THIS DRAW")
		
		field(:total_balance, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "B.2. TOTAL BALANCE")

		field(:others_liable, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "C. YES/NO (Others liable?)")
		field(:others_liable, ["5.3", "5.2", "5.1", "5.00", "3.00"], "C. YESNO (Others liable?)")

		field(:collateral, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "D. YES/NO (Collateral?)")
		field(:collateral, ["5.3", "5.2", "5.1", "5.00", "3.00"], "D. YESNO (Collateral?)")

		field(:collateral_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "D.1 DESCRIPTION  (IF YES, Specify)")
		field(:collateral_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "D.1 DESC (Collateral)")

		field(:collateral_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "D.2 COLLATERAL VALUE/AMOUNT")

		field(:perfected_interest, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "D.3 YES/NO  (Perfected Interest?)")
		field(:perfected_interest, ["5.3", "5.2", "5.1", "5.00", "3.00"], "D.3 YESNO  (Perfected Interest?))")

		field(:future_income, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "E.1 YES/NO  (Future Income?)")
		field(:future_income, ["5.3", "5.2", "5.1", "5.00", "3.00"], "E.1 YESNO  (Future Income)")
		
		field(:future_income_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "E.2  DESCRIPTION  (IF YES, Specify)")
		field(:future_income_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "E.2  DESC  (Specification of the above)")

		field(:future_income_estimated_value, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.3 ESTIMATED VALUE")

		field(:future_income_depository_account_established_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "E.4 ESTABLISHED DATE (Depository account)")
		field(:future_income_depository_account_established_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "E.4 DATE (Depository account established)")

		field(:future_income_depository_account_location_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "E.5 ACCOUNT LOCATION NAME")
		field(:future_income_depository_account_location_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "E.5 IND/NAME (Account Location)")

		field(:future_income_depository_account_location_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.6 STREET  1")

		field(:future_income_depository_account_location_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.7 STREET  2")

		field(:future_income_depository_account_location_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.8 CITY")

		field(:future_income_depository_account_location_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.9 STATE")

		field(:future_income_depository_account_location_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "E.10 ZIP")

		field(:future_income_depository_account_authorization_date_presidential, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "E.11 DEPOSIT ACCT AUTH DATE (Presidential)")
		field(:future_income_depository_account_authorization_date_presidential, ["5.3", "5.2", "5.1", "5.00", "3.00"], "E.11 DEP ACCT AUTH DATE (Presidential)")

		field(:basis_of_loan_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "F. BASIS OF LOAN DESCRIPTION")
		field(:basis_of_loan_description, ["5.3", "5.2", "5.1", "5.00", "3.00"], "F. DESC (State basis of loan)")

		field(:treasurer_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. TREASURER LAST NAME")
		field(:treasurer_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. NAME/TREASURER (as signed)", {:split => true, :split_index => 0})

		field(:treasurer_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. TREASURER FIRST NAME")
		field(:treasurer_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. NAME/TREASURER (as signed)", {:split => true, :split_index => 1})

		field(:treasurer_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. TREASURER MIDDLE NAME")
		field(:treasurer_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. NAME/TREASURER (as signed)", {:split => true, :split_index => 100})

		field(:treasurer_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. TREASURER PREFIX")
		field(:treasurer_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. NAME/TREASURER (as signed)", {:split => true, :split_index => 2})

		field(:treasurer_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. TREASURER SUFFIX")
		field(:treasurer_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. NAME/TREASURER (as signed)", {:split => true, :split_index => 3})


		field(:date_signed, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "G. DATE SIGNED")
		field(:date_signed, ["5.3", "5.2", "5.1", "5.00", "3.00"], "G. SIG/DATE")


		field(:authorized_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED LAST NAME")
		field(:authorized_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. NAME/AUTH (as signed)")

		field(:authorized_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED FIRST NAME")
		field(:authorized_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. NAME/AUTH (as signed))")

		field(:authorized_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED MIDDLE NAME")
		field(:authorized_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. NAME/AUTH (as signed)")

		field(:authorized_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED PREFIX")
		field(:authorized_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. NAME/AUTH (as signed)")

		field(:authorized_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED SUFFIX")
		field(:authorized_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. NAME/AUTH (as signed)")


		field(:authorized_title, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. AUTHORIZED TITLE")
		field(:authorized_title, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. AUTH/TITLE  ")


		field(:authorized_date_signed, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "H. DATE SIGNED")
		field(:authorized_date_signed, ["5.3", "5.2", "5.1", "5.00", "3.00"], "H. AUTH/SIG DATE")

	end
end

class ScheduleC2 < FECForm
	
	register(:SC2, ScheduleC2)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")

		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")

		field(:guarantor_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR LAST NAME")
		field(:guarantor_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (Endorser/Guarantor)")

		field(:guarantor_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR FIRST NAME")
		field(:guarantor_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (Endorser/Guarantor)")

		field(:guarantor_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR MIDDLE NAME")
		field(:guarantor_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (Endorser/Guarantor)")

		field(:guarantor_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR PREFIX")
		field(:guarantor_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (Endorser/Guarantor)")

		field(:guarantor_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR SUFFIX")
		field(:guarantor_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (Endorser/Guarantor)")

		field(:guarantor_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET 1")
		field(:guarantor_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET 1")

		field(:guarantor_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STREET 2")
		field(:guarantor_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET 2")

		field(:guarantor_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER CITY")
		field(:guarantor_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:guarantor_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER STATE")
		field(:guarantor_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:guarantor_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "LENDER ZIP")
		field(:guarantor_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")

		field(:guarantor_employer, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR EMPLOYER")
		field(:guarantor_employer, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INDEMP")

		field(:guarantor_occupation, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTOR EMPLOYER")
		field(:guarantor_occupation, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INDOCC")

		field(:guaranteed_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "GUARANTEED AMOUNT")
		field(:guaranteed_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMOUNT GUARANTEED BALANCE")
		
	end
end

class ScheduleD < FECForm
	register(:SD, ScheduleD)	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")

		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")
		
		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")

		field(:creditor_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR ORGANIZATION NAME")
		field(:creditor_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")
		
		field(:creditor_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR LAST NAME")
		field(:creditor_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")

		field(:creditor_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR FIRST NAME")
		field(:creditor_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")

		field(:creditor_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR MIDDLE NAME")
		field(:creditor_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")

		field(:creditor_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR PREFIX")
		field(:creditor_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")

		field(:creditor_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR SUFFIX")
		field(:creditor_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Debtor/Creditor)")		
		
		field(:creditor_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR STREET  1")
		field(:creditor_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:creditor_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR STREET  2")
		field(:creditor_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:creditor_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR CITY")
		field(:creditor_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:creditor_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR STATE")
		field(:creditor_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:creditor_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CREDITOR ZIP")
		field(:creditor_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")		

		field(:purpose_of_debt, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PURPOSE OF DEBT OR OBLIGATION")
		field(:purpose_of_debt, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NATURE/PURPOSE DEBT DESCRIPTION")		

		field(:beginning_balance_this_period, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BEGINNING BALANCE (This Period)")
		field(:beginning_balance_this_period, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BEGINNING BALANCE")		

		field(:incurred_amount_this_period, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "INCURRED AMOUNT (This Period)")
		field(:incurred_amount_this_period, ["5.3", "5.2", "5.1", "5.00", "3.00"], "INCURRED THIS PERIOD")		

		field(:payment_amount_this_period, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYMENT AMOUNT (This Period)")
		field(:payment_amount_this_period, ["5.3", "5.2", "5.1", "5.00", "3.00"], "PAYMENT THIS PERIOD")		

		field(:close_balance_this_period, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BALANCE AT CLOSE  (This Period)")
		field(:close_balance_this_period, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BALANCE AT CLOSE")		
	end
end

class FECText < FECForm
	register(:TEXT, FECText)
	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:text, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"],"TEXT4000")
	end
end

class ScheduleE < FECForm
	register(:SE, ScheduleE)	
	def initialize(schedule, version)
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")
		
		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")
		
		field(:back_reference_schedule, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE SCHED NAME")
		field(:back_reference_schedule, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF SCHED NAME")
		
		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")	

		field(:payee_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ORGANIZATION NAME")
		field(:payee_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE LAST NAME")
		field(:payee_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE FIRST NAME")
		field(:payee_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE MIDDLE NAME")
		field(:payee_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE PREFIX")
		field(:payee_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE SUFFIX")
		field(:payee_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")		
		
		field(:payee_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  1")
		field(:payee_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:payee_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  2")
		field(:payee_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:payee_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CITY")
		field(:payee_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:payee_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STATE")
		field(:payee_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:payee_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ZIP")
		field(:payee_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")		

		field(:election_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION CODE")
		field(:election_code, ["5.3", "5.2", "5.1", "5.00"], "ITEM ELECT CD")
		
		field(:election_other_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "ELECTION OTHER DESCRIPTION")
		field(:election_other_description, ["5.3", "5.2", "5.1", "5.00"], "ITEM ELECT OTHER")

		field(:expenditure_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE DATE")
		field(:expenditure_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE")		

		field(:expenditure_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE AMOUNT")
		field(:expenditure_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMOUNT EXPENDED")		

		field(:amount_spent_ytd, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "CALENDAR Y-T-D (per election/office)")
		field(:amount_spent_ytd, ["5.3", "5.2", "5.1", "5.00"], "CALENDAR YTD - OFFICE SOUGHT")
		
		field(:expenditure_purpose_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE CODE")
		field(:expenditure_purpose_code, ["5.3", "5.2", "5.1", "5.00"], "TRANS CODE")

		field(:expenditure_purpose_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE DESCRIP")
		field(:expenditure_purpose_description, ["5.3", "5.2", "5.1", "5.00"], "TRANS {Purpose} DESCRIP")
		field(:expenditure_purpose_description, ["3.00"], "TRANSDESC ")

		field(:expenditure_category_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CATEGORY CODE")	

		field(:payee_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CMTTE FEC ID NUMBER")
		field(:payee_committee_fecid, ["5.3", "5.2", "5.1", "5.00","3.00"], "FEC COMMITTEE ID NUMBER")

		field(:support_oppose_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUPPORT/OPPOSE CODE  ")
		field(:support_oppose_code, ["5.3", "5.2", "5.1", "5.00","3.00"], "SUPPORT/OPPOSE   ")

		field(:support_oppose_candidate_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE ID NUMBER")
		field(:support_oppose_candidate_fecid, ["5.3", "5.2", "5.1", "5.00","3.00"], "S/O FEC CAN ID NUMBER")

		field(:support_oppose_candidate_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE LAST NAME")
		field(:support_oppose_candidate_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/NAME")

		field(:support_oppose_candidate_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE FIRST NAME")
		field(:support_oppose_candidate_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/NAME")

		field(:support_oppose_candidate_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE MIDDLE NAME")
		field(:support_oppose_candidate_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/NAME")

		field(:support_oppose_candidate_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE PREFIX")
		field(:support_oppose_candidate_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/NAME")

		field(:support_oppose_candidate_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE SUFFIX")
		field(:support_oppose_candidate_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/NAME")		

		field(:support_oppose_candidate_office, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE OFFICE")
		field(:support_oppose_candidate_office, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/OFFICE")		

		field(:support_oppose_candidate_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE STATE")
		field(:support_oppose_candidate_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O STATE")		
		
		
		field(:support_oppose_candidate_district, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "S/O CANDIDATE DISTRICT")
		field(:support_oppose_candidate_district, ["5.3", "5.2", "5.1", "5.00", "3.00"], "S/O CAN/DIST")		


		field(:completing_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COMPLETING LAST NAME")
		field(:completing_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (as signed)")

		field(:completing_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COMPLETING FIRST NAME")
		field(:completing_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (as signed)")

		field(:completing_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COMPLETING MIDDLE NAME")
		field(:completing_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (as signed)")

		field(:completing_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COMPLETING PREFIX")
		field(:completing_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (as signed)")

		field(:completing_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "COMPLETING SUFFIX")
		field(:completing_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "IND/NAME (as signed)")		

		field(:date_signed, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DATE SIGNED")
		field(:date_signed, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE (Signed)")		

		field(:memo_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO CODE")	
		
		field(:memo_text, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "MEMO TEXT/DESCRIPTION")
		field(:memo_text, ["5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO TEXT")

	end
end


class ScheduleF < FECForm
	
	register(:SF, ScheduleF)
	
	def initialize(schedule, version)
		
		super(schedule, version)
		
		field(:committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "FILER COMMITTEE ID NUMBER")
		field(:committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FILER FEC CMTE ID")
		
		field(:transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "TRANSACTION ID NUMBER")
		field(:transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "TRAN ID")

		field(:back_reference_transaction_id, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE TRAN ID NUMBER")
		field(:back_reference_transaction_id, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF TRAN ID")
		
		field(:back_reference_schedule, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "BACK REFERENCE SCHED NAME")
		field(:back_reference_schedule, ["5.3", "5.2", "5.1", "5.00", "3.00"], "BACK REF SCHED NAME")

		field(:files_designated_to_make_coordinated_expenditures, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "YES/NO  (Has filer been designated to make Coodinated Expenditures?)")
		field(:files_designated_to_make_coordinated_expenditures, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DESIG YES/NO (Has Filer Been Desig.To Make Cord.Expend.)")

		field(:designating_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DESIGNATING COMMITTEE ID NUMBER")
		field(:designating_committee_fecid, ["5.3", "5.2", "5.1", "5.00", "3.00"], "FEC COMMITTEE ID NUMBER (Designating)")

		field(:designating_committee_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "DESIGNATING COMMITTEE NAME")
		field(:designating_committee_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "COMMITTEE NAME (Designating)")
		
		field(:subordinate_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUBORDINATE STREET  1")
		field(:subordinate_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:subordinate_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUBORDINATE STREET  2")
		field(:subordinate_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:subordinate_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUBORDINATE CITY")
		field(:subordinate_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:subordinate_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUBORDINATE STATE")
		field(:subordinate_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:subordinate_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "SUBORDINATE ZIP")
		field(:subordinate_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")		

		field(:entity_type, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "ENTITY TYPE")	
		
		field(:payee_organization_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ORGANIZATION NAME")
		field(:payee_organization_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE LAST NAME")
		field(:payee_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE FIRST NAME")
		field(:payee_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE MIDDLE NAME")
		field(:payee_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE PREFIX")
		field(:payee_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")

		field(:payee_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE SUFFIX")
		field(:payee_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "NAME (Payee)")		
		
		field(:payee_street_1, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  1")
		field(:payee_street_1, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  1")

		field(:payee_street_2, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STREET  2")
		field(:payee_street_2, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STREET  2")

		field(:payee_city, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CITY")
		field(:payee_city, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CITY")

		field(:payee_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE STATE")
		field(:payee_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "STATE")

		field(:payee_zip, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE ZIP")
		field(:payee_zip, ["5.3", "5.2", "5.1", "5.00", "3.00"], "ZIP")		
		
		field(:expenditure_date, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE DATE")
		field(:expenditure_date, ["5.3", "5.2", "5.1", "5.00", "3.00"], "DATE")	
		
		field(:expenditure_amount, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE AMOUNT")
		field(:expenditure_amount, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AMOUNT")	

		field(:aggregate_amount_expended_for_general_election, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "AGGREGATE GENERAL ELEC EXPENDED")
		field(:aggregate_amount_expended_for_general_election, ["5.3", "5.2", "5.1", "5.00", "3.00"], "AGG. GEN. ELE. AMOUNT EXPENDED")	

		field(:expenditure_purpose_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE CODE")
		field(:expenditure_purpose_code, ["5.3", "5.2", "5.1", "5.00"], "TRANS CODE")

		field(:expenditure_purpose_description, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "EXPENDITURE PURPOSE DESCRIP")
		field(:expenditure_purpose_description, ["5.3", "5.2", "5.1", "5.00"], "TRANS {Purpose} DESCRIP")
		field(:expenditure_purpose_description, ["3.00"], "TRANSDESC ")
		
		field(:expenditure_category_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00"], "CATEGORY CODE")	

		field(:increased_limit, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "INCREASED LIMIT")
		field(:increased_limit, ["5.3", "5.2", "5.1", "5.00"], "UNLIMITED SPENDING")

		field(:payee_candidate_committee_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE COMMITTEE ID NUMBER")
		field(:payee_candidate_committee_fecid, ["5.3", "5.2", "5.1", "5.00","3.00"], "FEC COMMITTEE ID NUMBER")

		field(:payee_candidate_fecid, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE ID NUMBER")
		field(:payee_candidate_fecid, ["5.3", "5.2", "5.1", "5.00","3.00"], "FEC CANDIDATE ID NUMBER")
		
		field(:payee_candidate_last_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE LAST NAME")
		field(:payee_candidate_last_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:payee_candidate_first_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE FIRST NAME")
		field(:payee_candidate_first_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:payee_candidate_middle_name, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE MIDDLE NAME")
		field(:payee_candidate_middle_name, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:payee_candidate_prefix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE PREFIX")
		field(:payee_candidate_prefix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")

		field(:payee_candidate_suffix, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE SUFFIX")
		field(:payee_candidate_suffix, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CANDIDATE NAME")


		field(:payee_candidate_office, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE OFFICE")
		field(:payee_candidate_office, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/OFFICE")

		field(:payee_candidate_state, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE STATE ")
		field(:payee_candidate_state, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/STATE   ")

		field(:payee_candidate_district, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "PAYEE CANDIDATE DISTRICT")
		field(:payee_candidate_district, ["5.3", "5.2", "5.1", "5.00", "3.00"], "CAN/DIST")
		
		field(:memo_code, ["8.0","7.0","6.4","6.3", "6.2", "6.1","5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO CODE")	
		
		field(:memo_text, ["8.0","7.0","6.4","6.3", "6.2", "6.1"], "MEMO TEXT/DESCRIPTION")
		field(:memo_text, ["5.3", "5.2", "5.1", "5.00", "3.00"], "MEMO TEXT")
	end
end
	