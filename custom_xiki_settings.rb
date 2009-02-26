# $el.set_frame_size(View.frame, 95, 52);  $el.set_frame_position(View.frame, 748, 22)

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
           :notes_h1r => "771111",
           :notes_h1o => "994411",
           :notes_h1y => "aa9933",
           :notes_h1e => "336633",
           :notes_h1g => "336633",
           :notes_h1p => "663366",
           :notes_h1m => "330000",
           :notes_h1x => "333333"}

styles.each do |k, bg|
  header = bg.gsub(/../) {|c| (c.to_i(16) + "33".to_i(16)).to_s(16)}
  Styles.define k,                  :face => 'arial', :size => h1_size, :fg => 'ffffff', :bg => bg, :bold =>  true
  Styles.define "#{k}_pipe".to_sym, :face => 'arial', :size => "1",       :fg => bg,       :bg => bg, :bold =>  true
end


# Added for john compatibility
Keys.set("C-;") { CodeTree.display_menu("- Buffers.current/") }

(0..9).each do |i|
  Keys.set("M-#{i}") { Bookmarks.go("$#{i}") }
end

Keys.custom_load(:notes_mode_map) { $el.insert "| Today - #{Time.now.strftime("%A, %b. %d, %Y")}
- week of the year: #{Time.now.strftime("%U")} (#{(Time.now.strftime("%U").to_i * 100 / 52)}%)
#{Time.now.strftime("- %I:%M%p: ").downcase.sub(' 0', ' ')}started
- 
" }
Keys.custom_job(:notes_mode_map) { $el.insert "| name (#{Time.now.strftime("%Y-%m-%d")})
- define goal:
- why do this?:
- priority/date:
- next steps:
" }

# Keys.do_expand { $el.dabbrev_completion nil }

# $el.define_key :ruby_mode_map, "\t" do
#   $el.dabbrev_completion nil
# end

PROJECTS_DIR = '/Users/keith/workspace/'
projects = Dir.new(PROJECTS_DIR).entries
projects -= ['.', '..', '.DS_Store']
PROJECTS = projects

Projects.listing = PROJECTS.inject({}) do |projects, project|
  projects[project] = File.join(PROJECTS_DIR, project)
  projects
end

class Bookmarks
  BOOKMARK_LOG = "/tmp/bookmark_log.notes"
end

FileTree.one_view_in_bar_by_default = true

class FileTree
  def before_grep(entries)
    entries.reject! { |path| (path =~ /vendor|log/)  }
  end
end

Keys._F { FileTree.ls(:dir => (Bookmarks.expand("$tr").chomp('/') + '/')) }
Keys._S { Search.tree_grep(Bookmarks.expand("$tr").chomp('/') + '/' ) }
