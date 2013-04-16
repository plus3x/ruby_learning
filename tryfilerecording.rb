class TryFileRecords
  def try(type, file, data)
    puts "#{data + ["\n"]}"
    recording_file_with_optional type, file, data
    write_on_screen file
    delete file
  end

  def recording_file_with_optional( type, file, data )
    @kyes_for_acces = %w(w w+ a a+)

    @kyes_for_acces.each do |key|
      case type
        when '<<' then open(file + key, key) << data
        when '{<<}' then open(file + key, key) { |f| f << data }
        when 'puts' then open(file + key, key).puts data
        when '{puts}' then open(file + key, key) { |f| f.puts data }
        when 'puts(&:)' then open(file + key, key).puts(&:data)
        when 'puts[]' then open(file + key, key).puts [data]
        when 'puts+\\n' then open(file + key, key).puts data + ["\n"]
      end
    end
  end

  def write_on_screen file
    @kyes_for_acces.each { |key| puts "#{file + key} = #{open(file + key).readlines}" }
  end

  def delete file
    @kyes_for_acces.each { |key| File.delete(file + key) if File.exist?(file + key) }
  end
end

puts "*" * 100
puts "Test file recording"
types_recording = %w(<< {<<} puts {puts} puts(&:) puts[] puts+\\n)
types_recording.each do |type| 
  puts "Recording type is #{type}"
  TryFileRecords.new.try(type,"filetest.txt", %w(data for file test))
end
