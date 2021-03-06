#http://www.germane-software.com/software/rexml/docs/tutorial.html
#this convter
require 'rexml/document'
require "date"
require "stringex"

## -- Misc Configs -- ##
#Dir.pwd = "/home/jhjguxin/jhjguxin.github.com"
public_dir      = "public"    # compiled site directory
source_dir      = "source"    # source file directory
blog_index_dir  = 'source'    # directory for your blog's index page (if you put your index in source/blog/index.html, set this to 'source/blog')
deploy_dir      = "_deploy"   # deploy directory (for Github pages deployment)
stash_dir       = "_stash"    # directory to stash posts for speedy generation
posts_dir       = "_posts"    # directory for blog files
themes_dir      = ".themes"   # directory for blog files
new_post_ext    = "markdown"  # default new post file extension when using the new_post task
new_page_ext    = "markdown"  # default new page file extension when using the new_page task
  server_port     = "4000"      # port for preview server eg. localhost:4000

def unescape( src )
  String.class_eval(%Q("#{src}"))
end

#p unescape("\\t\\n") == "\t\n"  #=> true

def load_xml_data(data_file = nil)
  date_file ||= "jhjguxin.wordpress.2012-10-14.xml"
  #template = File.open "template.markdown"
  if File.exist? date_file
    xmldata = REXML::Document.new(File.open date_file)
    posts =[]
    xmldata.elements.each("rss/channel/item") do |element|
      #title =  element.children[1].text
      #title = element.elements.to_a("title").first.text
      title = element.elements["title"].text
      content = "## #{title}\n" << element.elements["content:encoded"].text
      comments = (element.elements["wp:comment_status"].text.eql? "open") ? "true" : "false"

      categories =  []
      tags =  []
      element.elements.each("category"){|element| categories << element.text if element.attributes["domain"].eql? "category"}.compact
      categories = categories.join(",")

      element.elements.each("category"){|element| tags << element.text if element.attributes["domain"].eql? "post_tag"}.compact
      tags = tags.join(",")

      #puts "\n+++++++++++++++++++++++++++++++++"
      #puts "_____categories____"
      #puts categories
      #puts "==================================="
      #puts "_____tags____"
      #puts tags
      #puts "+++++++++++++++++++++++++++++++++\n"

      #puts element.children[1].text
      if element.elements["wp:post_date"].text.empty?
        date = DateTime.now
      else
        date = DateTime.parse element.elements["wp:post_date"].text
      end

      posts << {title: title, date: date, content: content, comments: comments, categories: categories, tags: tags}
      #create_new_post(title: title, date: date, content: content, comments: comments, categories: categories)
    end

    posts
  else
    raise "### You haven't set date_file yet. or date_file not exists."
  end
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
def create_new_post(params = {})

  ## -- Misc Configs -- ##
  #Dir.pwd = "/home/jhjguxin/jhjguxin.github.com"
  public_dir      = "public"    # compiled site directory
  source_dir      = "source"    # source file directory
  blog_index_dir  = 'source'    # directory for your blog's index page (if you put your index in source/blog/index.html, set this to 'source/blog')
  deploy_dir      = "_deploy"   # deploy directory (for Github pages deployment)
  stash_dir       = "_stash"    # directory to stash posts for speedy generation
  posts_dir       = "_posts"    # directory for blog files
  themes_dir      = ".themes"   # directory for blog files
  new_post_ext    = "markdown"  # default new post file extension when using the new_post task
  new_page_ext    = "markdown"  # default new page file extension when using the new_page task
  server_port     = "4000"      # port for preview server eg. localhost:4000


  title = params.delete(:title)
  title ||= 'new-post'
  date  = params.delete(:date)
  comments  = params.delete(:comments)
  categories  = params.delete(:categories)
  content  = params.delete(:content)
  tags  = params.delete(:tags)

  puts "Begin a new post in #{source_dir}/#{posts_dir}"
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  puts "set posts_dir"
  `mkdir -p "#{source_dir}/#{posts_dir}"`

  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end

=begin
  puts "Creating new post: #{filename} on #{filename}"
  puts "---"
  puts "layout: post"
  puts "title: \"#{title.gsub(/&/,'&amp;')}\""
  puts "date: #{date.strftime('%Y-%m-%d %H:%M')}"
  puts "comments: #{comments}"
  puts "categories: #{categories}"
  puts "tags: #{tags}"
  puts "---\n"
  puts "#{content}"
=end

  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{date.strftime('%Y-%m-%d %H:%M')}"
    post.puts "comments: #{comments}"
    post.puts "categories: [#{categories}]"
    post.puts "tags: [#{tags}]"
    post.puts "---\n"
    post.puts "#{content}"
  end

end

def convert_to_octopress
  posts = load_xml_data("jhjguxin.wordpress.2012-10-14.xml")
  if !(posts.empty?)
    posts.each do |post|
      puts "begin to create post #{post[:title]}"
      #create_new_post(title: title, date: date, content: content, comments: comments, categories: categories)
      create_new_post(post)
      puts "post already create at #{DateTime.now.strftime('%Y-%m-%d %H:%M')}"
    end
  else
    puts "Could not find post data ..."
  end
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
desc "load wordpress posts to octopress from it's xmldata file in #{source_dir}/#{posts_dir}"
task :wordpress_octoptess_converter do
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{posts_dir}"
  puts "begin to loading ..."
  convert_to_octopress
end
