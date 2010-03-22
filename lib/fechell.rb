require "rubygems"
require "fastercsv"

class FECHell

	@@modules = nil

	@@valid_lines = {
						 "F1" => ["HDR", "TEXT"],
						 "F1S" => ["HDR", "TEXT"],
						 "F1M" => ["HDR", "TEXT"],
						 "F2" => ["HDR", "TEXT"],
						 "F2S" => ["HDR", "TEXT"],
						 "F24" => ["HDR", "SE", "SF", "TEXT"],
						 "F3" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3S" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3X" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3Z" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],						 
						 "F3P" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3PS" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3P31" => ["HDR", "SA", "SB", "SC", "SC1", "SC2", "SD","TEXT"],
						 "F3L" => ["HDR", "SA3L", "SB3L","TEXT"],
						 "F4" => ["HDR", "SA", "SB", "SC", "SD","TEXT"],
						 "F5" => ["HDR", "F56", "F57"],
						 "F6" => ["HDR", "F65"],
						 "F7" => ["HDR", "F76"],
						 "F8" => ["HDR", "F82", "F83"],
						 "F9" => ["HDR", "F91","F92","F93","F94" ],
						 "F10" => ["HDR", "F10.5"],
						 "F13" => ["HDR", "F132", "F133"],
						 "F99" => ["HDR","[BEGINTEXT]"]						 						 
						}


	SEPERATORS = {"3.00" => ",",
								"5.00" => ",",
								"5.1" => ",",
								"5.2" => ",",
								"5.3" => ",",
								"6.1" => "\x1e",
								"6.2" => "\x1e",
								"6.3" => "\x1e",
								"6.4" => "\x1e"
							 }
							 
				
	def self.load_modules
  	@@modules = {}
		Dir["#{File.dirname(__FILE__)}/defs/*.csv"].each do |filename|
			version = File.basename(filename,".csv")
			
			formats = {}

			FasterCSV.open(filename,"r",:col_sep => ';').each do |line|
				schedule = line[0].gsub(' ','').gsub('Sch','S')
				formats[schedule] = line[1..-1]				
			end

			@@modules[version] = formats

		end

	end

	def initialize
		FECHell.load_modules unless @@modules.nil? == false	
		
		@form_matcher = Regexp.new("^(#{@@valid_lines.keys.sort { |l,r| r.size <=> l.size} .join('|')})[ANT]?")
	end

	def clean_fec_version(version)
		out_version = version

		# monkey patch messed up version names in older software (Public Affairs Support Services Inc.)
		
		out_version = "5.3" if version == "5.30"

		out_version = "3.00" if version == "3.0"

		out_version
	end

	def peek_format(data)

		header = {}
		parts_raw = []
		first_line = []
		form_type = ''

		lines = []

		begin

			if data.is_a?(Array) then
				lines = data[0..1]
			else
				if data.is_a?(StringIO) then
					file = data
				elsif data.is_a?(String)
					file = File.open(data,"r")
				end
				lines[0] = file.readline
				lines[1] = file.readline.gsub(/\r\n?/, "").gsub("\n\r?", "").gsub("\n", "")
				#sometimes the 2nd line is blank. argh
				if lines[1] == ""
					# read until we're not nil anymore
					while lines[1] == ""
						lines[1] = file.readline.gsub(/\r\n?/, "").gsub("\n\r?", "").gsub("\n", "")
					end
				end
				lines[1] ||= ""
			end
			
			line = lines[0]
			header = {}
			if line =~ /^\/\* Header/ then
				seperator = ","
				line = lines[1]
				while (line =~ /^\/\* End Header/).nil? == true
					key,value = line.split("=")				
					if key =~ /^FEC_Ver_*/
						header[:fec_version] = clean_fec_version(value.strip!)
					end
					line = file.readline
				end
				header[:record_type] = "HDR"
				line = file.readline
			else
				seperator = guess_seperator(lines[0])
				line = line.gsub!(/\n/,"").strip

				parts_raw = FasterCSV.parse(line,:col_sep => seperator,:skip_blanks => true)[0]

				header[:record_type] = parts_raw[0]
				header[:ef_type] = parts_raw[1]
				header[:fec_version] = clean_fec_version(parts_raw[2])
				header[:software_name] = parts_raw[3]
				header[:software_version] = parts_raw[4]
				header[:report_id] = parts_raw[5]
				header[:report_number] = parts_raw[6]
				line = lines[1]
			end
			line = line.strip
			parts_raw = FasterCSV.parse(line,:col_sep => seperator)[0]
			form_type = parts_raw[0]
			parts_raw.shift
			
			file.close unless file.nil?
		rescue FasterCSV::MalformedCSVError
			header = {}
			parts_raw = []
			first_line = []
			form_type = ''
		end	
		return seperator,header,form_type,parts_raw
	end

	def guess_seperator(first_line)
		seperator = ","
		if first_line.index(28).nil? == false then
			seperator = "\x1c"
		end

		seperator
	end
	
	def schedules_for(version)
		@@modules[version]
	end

	def fields_for(version,schedule)
		@@modules[version][schedule.upcase]
	end

	def guess_schedule(version,full_schedule)
		schedules = []

		# 1st we look for an exact match
		# otherwise we look for a partial match, taking into account appended returns
		full_schedule.upcase!
		version.strip!
		if @@modules[version].keys.index(full_schedule)
			schedules << full_schedule
		else
			@@modules[version].keys.each do |key|
				if full_schedule[0...1] == 'F' # F[number] can have an 'N','A' at the end
					regex = "^#{key}[ANT]?"
				else # TEXT or Schedules. S[Letter][numbers]
					regex = "^#{key}"
				end
				if full_schedule.match(regex)
					schedules << key
				end
			end
		end

    # return the longest match first
		schedules.sort { |l,r| r.size <=> l.size }
	end

	def header_lines(filename)
		seperator,header,form_type,elements = peek_format(filename)	

		schedule = guess_form(form_type)

		if header[:fec_version].to_i < 3 then
			return header[:fec_version],form_type,schedule,nil
		end
				
		csv = FasterCSV.open(filename,"r",:col_sep => seperator,:skip_blanks => true)
		
		#schedules = guess_schedule(header[:fec_version],form_type)
		line = csv.readline
		
		if line =~ /^\/\* Header/ then
			while ((line =csv.readline) =~ /^\/\* End Header/).nil? == true
			end
		end
		
		line = csv.readline
		#schedule = line[0]
		if schedule.nil?
			schedules1 = []
			values1 = []
		else
			schedules1,values1 = process_line(header[:fec_version],schedule,line)
		end
		
		csv.close
		return header[:fec_version],form_type,schedules1[0],values1

	end

	def process_line(fec_version,schedule,line)

		guesses = guess_schedule(fec_version,schedule)	
		offsets = @@modules[fec_version][guesses[0]]
		values = {}
		index =0
		if offsets.nil? == true
			guesses = ["UNKNOWN"]
			values = {"line" => line}
		else
			offsets.each do |offset|
				values[offset] = line[index]
				index = index + 1
			end
		end

		return guesses,values
	end

	def guess_form(full_form)
		full_form ||= ""
		full_form.upcase!		
		md = @form_matcher.match(full_form)
		candidate_form =  md[1] unless md.nil? == true
		candidate_form
	end
	
	def process(filename,options = {})
			
		seperator,header,form_type,elements = peek_format(filename)					

		main_form = guess_form(form_type)
		
		if main_form == "UNKNOWN" then
			puts "ERROR: #{filename} - type was #{form_type} we found nothing"
		end
		
		valid_schedules_this_form = @@valid_lines[main_form]
		matcher = Regexp.new("^(#{valid_schedules_this_form.sort{ |l,r| r.size <=> l.size} .join('|')})")
		
		begin 
			FasterCSV.foreach(filename,:col_sep => seperator,:skip_blanks => true) do |line|
				next if line.nil?
				next if line.size == 0
				
				sch = line[0]
				matched_schedule = nil
				# first two lines are [FORM_TYPE] or HDR
				if sch == form_type
					matched_schedule = main_form
				elsif sch == "HDR"
					matched_schedule = sch
				else
					md = matcher.match(sch)
					matched_schedule = md[1] unless md.nil? == true
				end
				
				unless matched_schedule.nil? == true
					values = {}
					offsets = @@modules[header[:fec_version]][matched_schedule]
					index = 0
					
					offsets.each do |offset|
						values[offset] = line[index]
						index = index + 1
					end
					yield [matched_schedule, values]
				end					

			end
		rescue FasterCSV::MalformedCSVError
			puts "malformed content in file #{filename}"					
		end			
	end


	def process_oldmatcher(filename,options = {})
			
			seperator,header,form_type,elements = peek_format(filename)					

			schedules = guess_schedule(header[:fec_version],form_type)
			if schedules.size == 0 then
				puts "ERROR: #{filename} - type was #{form_type} we found nothing"
			end
			offsets = @@modules[header[:fec_version]][schedules[0]]
			matcher = Regexp.new('^[STFH]')	
					
			begin 
				FasterCSV.open(filename,:col_sep => seperator,:skip_blanks => true).each do |line|
					next if line.nil?
					next if line.size == 0
					sch = line[0]

					#next unless sch.match('^[STFH]')
					next unless matcher.match(sch)

					if form_type == 'F99'
						guesses = ["TEXT"]
						values = { "line" => line }
					else
						guesses,values = process_line(header[:fec_version],sch,line)
					end


					next if guesses.nil? || guesses.size == 0
					next if values.nil?

					if options[:ignore_schedules]
						match_str = "^#{options[:ignore_schedules].join('|')}"
						next if sch.match(match_str)
					end
					yield [guesses[0],values]

				end
			rescue FasterCSV::MalformedCSVError
				puts "malformed content in file #{filename}"					
			end			
	end

end
