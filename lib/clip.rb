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
  vndump.puts "  <body>"
  vndump.puts "    <span>#{text}</span>"
  vndump.puts "  </body>"
  vndump.puts "</html>"
  vndump.close
end

def check_clipboard(text)
  text == Clipboard.paste ? false : true
end

def run_loop(text='',first_run=true)
  if first_run
    puts "Now watching the clipboard for changes. Press Ctrl+C to stop the program."
  end
  
  current_clip_text = copy_clipboard_contents
  create_html(current_clip_text) if text != current_clip_text
    
  sleep 1
  
  run_loop(current_clip_text,false)
  at_exit { delete_file } #This doesn't work. Signal handler needed
end

run_loop