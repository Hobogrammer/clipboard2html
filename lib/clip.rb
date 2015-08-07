require 'clipboard'

def copy_clipboard_contents
  text = Clipboard.paste
  return text
end

def create_html(text)
  vndump = File.new('vndump.html','w+')
  file_contents(text, vndump)
end

def delete_file
  File.delete('vndump.html') if File.exist?('vndump.html')
end

def file_contents(text, vndump)
  vndump.puts "<html>"
  vndump.puts "  <head>"
  vndump.puts "    <title>VN clipboard dump</title>"
  vndump.puts "  </head>"
  vndump.puts "  <body bgcolor='black'>"
  vndump.puts "    <span><font color='white' size='24px'>#{text}</font></span>"
  vndump.puts "  </body>"
  vndump.puts "</html>"
  vndump.close
end

def main()

  flag = true

  while flag
    
  current_clip_text = copy_clipboard_contents
  create_html(current_clip_text) if text != current_clip_text
    
  sleep 0.5
  
  at_exit { delete_file } #This doesn't work. Signal handler needed
end

run_loop