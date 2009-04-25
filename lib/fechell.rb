require "rubygems"
require "fastercsv"

class FECHell

	@@modules = nil

	SEPERATORS = {"3.00" => ",",
								"5.00" => ",",
								"5.1" => ",",
								"5.2" => ",",
								"5.3" => ",",
								"6.1" => "\x1e",
								"6.2" => "\x1e"
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
				lines[1] = file.readline
				file.close
			end
			
			line = lines[0]

			seperator = guess_seperator(lines[0])
			parts_raw = FasterCSV.parse(line,:col_sep => seperator)[0]

			header[:record_type] = parts_raw[0]
			header[:ef_type] = parts_raw[1]
			header[:fec_version] = parts_raw[2]
			header[:software_name] = parts_raw[3]
			header[:software_version] = parts_raw[4]
			header[:report_id] = parts_raw[5]
			header[:report_number] = parts_raw[6]

			line = lines[1]
			parts_raw = FasterCSV.parse(line,:col_sep => seperator)[0]

			form_type = parts_raw[0]
			parts_raw.shift
			
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

	def fields_for(version,schedule)
		@@modules[version][schedule.upcase]
	end

	def guess_schedule(version,full_schedule)
		schedules = []

		# 1st we look for an exact match
		# otherwise we look for a partial match, taking into account appended returns
		full_schedule.upcase!

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

		csv = FasterCSV.open(filename,"r",:col_sep => seperator)
		
		schedules = guess_schedule(header[:fec_version],form_type)
		
		line = csv.readline
		line = csv.readline
		schedule = line[0]
		schedules1,values1 = process_line(header[:fec_version],schedule,line)
		
		csv.close
		return header[:fec_version],form_type,schedules1[0],values1

	end

	def process_line(fec_version,schedule,line)
		guesses = guess_schedule(fec_version,schedule)		

		offsets = @@modules[fec_version][guesses[0]]
		values = {}
		index =0
		offsets.each do |offset|
			values[offset] = line[index]
			index = index + 1
		end

		return guesses,values
	end

	def process(filename,options)
			
			seperator,header,form_type,elements = peek_format(filename)		

			schedules = guess_schedule(header[:fec_version],form_type)
			if schedules.size == 0 then
				puts "ERROR: #{filename} - type was #{form_type} we found nothing"
			end
			offsets = @@modules[header[:fec_version]][schedules[0]]
			begin 
				FasterCSV.open(filename,:col_sep => seperator).each do |line|
					next if line.nil?
					next if line.size == 0
					sch = line[0]

					next unless sch.match('^[STF]')

					guesses,values = process_line(header[:fec_version],sch,line)

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
