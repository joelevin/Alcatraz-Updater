#!/usr/bin/env ruby
require 'Shellwords'

def show_wait_spinner(fps=10)
  chars = %w[| / - \\]
  delay = 1.0/fps
  iter = 0
  spinner = Thread.new do
    while iter do  # Keep spinning until told otherwise
      print chars[(iter+=1) % chars.length]
      sleep delay
      print "\b"
    end
  end
  yield.tap{       # After yielding to the block, save the return value
    iter = false   # Tell the thread to exit, cleaning up after itself…
    spinner.join   # …and wait for it to do so.
  }                # Use the block's return value as the method's
end

puts "\nHello!  We are going to update the DVTPlugInCompatibilityUUIDs for each Alcatraz plug-in."
current_uuid = `defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID`
puts "The current UUID is " + current_uuid
plugin_path = Shellwords.escape("/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins")
formatted_command = "find ~" + plugin_path + " -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add " + current_uuid
puts "We will execute this command to update the plug-ins: \n" + formatted_command
show_wait_spinner {
	execution_result = system(formatted_command)
	if execution_result
		puts "\nPlug-ins updated successfully"
	else
		puts "\nThere was an error updating your plug-ins."
	end
}

