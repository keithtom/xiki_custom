$el.set_frame_size(View.frame, 145, 50);  $el.set_frame_position(View.frame, 223, 22)

class Notes

  NOTES_BOOKMARK = '$notes'

  def self.menu notes_file=nil
    if notes_file == nil
      puts '- xiki'
      puts '- next_step'
      puts '- blog'
      puts '- learning'
      return
    end
    path = Bookmarks.expand(NOTES_BOOKMARK) + "/" + notes_file + ".notes"
    View.open(path)
  end
end


# |...
h1_size = "+20"

styles = { :notes_h1  => "666699",
           :notes_h1i => "66aa66",
           :notes_h1e => "cccc66",
           :notes_h1c => "996699",
           :notes_h1s => "449688",
           :notes_h1n => "eeaa33"}

# styles.each do |k, v|
#   header = v.gsub(/../) {|c| (c.to_i(16) + "33".to_i(16)).to_s(16)}
#   Styles.define k,                  :face => 'arial', :size => h1_size, :fg => 'ffffff', :bg => v, :bold =>  true
#   Styles.define "#{k}_pipe".to_sym, :face => 'arial', :size => h1_size, :fg => v,        :bg => v, :bold =>  true
# end


# Added for john compatibility
Keys.set("C-;") { CodeTree.display_menu("- Buffers.current/") }

(0..9).each do |i|
  Keys.set("M-#{i}") { Bookmarks.go("$#{i}") }
end

Keys.do_expand { $el.dabbrev_completion nil }

# $el.define_key :ruby_mode_map, "\t" do
#   $el.dabbrev_completion nil
# end

Projects.listing = { :bt => '/Users/keith/workspace/braintree-gateway',
                     :expenses => '/Users/keith/workspace/expenses',
                     :xiki => '/Users/keith/workspace/xiki' }

