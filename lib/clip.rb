#! /usr/bin/env ruby

require 'win32/clipboard'
include Win32

def create_html(current_text)
  vndump = File.new('vndump.html','w+')
  file_contents(current_text, vndump)
end

def delete_file
  File.delete('vndump.html') if File.exist?('vndump.html')
end

def file_contents(current_text, vndump)
  vndump.puts "<html>"
  vndump.puts "  <head>"
  vndump.puts "    <title>VN clipboard dump</title>"
  vndump.puts "  </head>"
  vndump.puts "  <body bgcolor='black'>"
  vndump.puts "    <span><font color='white' size='18px'>#{current_text}</font></span>"
  vndump.puts "  </body>"
  vndump.puts "</html>"
  vndump.close
end

def process_clip_change(current_text)
  create_html(current_text)
end


def main()
  flag = true
  prev_text = ''
  puts "Now monitoring the clipboard for changes. Press Ctrl+C to close the program."
  
  while flag
    begin
      current_text = Clipboard.data(Clipboard::UNICODETEXT)
      current_text = current_text.split("\u{000}")[0]
    rescue
      puts "Clipboard gem has failed to sucessfully retrieve text from the clipboard. Skipping"
    end
    if prev_text != current_text
      create_html(current_text)
      prev_text = current_text
    end
    sleep 0.5 
  end 
end

Signal.trap("INT"){
  delete_file
  exit
}
main
