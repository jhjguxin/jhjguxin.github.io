#http://www.germane-software.com/software/rexml/docs/tutorial.html
#this convter
require 'rexml/document'
require "date"

## -- Misc Configs -- ##

public_dir      = "../public"    # compiled site directory
source_dir      = "../source"    # source file directory
blog_index_dir  = '../source'    # directory for your blog's index page (if you put your index in source/blog/index.html, set this to 'source/blog')
#deploy_dir      = "../_deploy"   # deploy directory (for Github pages deployment)
stash_dir       = "_stash"    # directory to stash posts for speedy generation
posts_dir       = "_posts"    # directory for blog files
#themes_dir      = "../.themes"   # directory for blog files
new_post_ext    = "markdown"  # default new post file extension when using the new_post task
#new_page_ext    = "markdown"  # default new page file extension when using the new_page task
#server_port     = "4000"      # port for preview server eg. localhost:4000



def unescape( src )
  String.class_eval(%Q("#{src}"))
end

#p unescape("\\t\\n") == "\t\n"  #=> true

def load_xml_data(data_file = nil)
  date_file ||= "jhjguxin.wordpress.2012-10-14.xml"
  xmldata = REXML::Document.new(File.open date_file)
  #template = File.open "template.markdown"
  if File.exist? "date_file"
    posts =[]
    xmldata.elements.each("rss/channel/item") do |element|
      #title =  element.children[1].text
      #title = element.elements.to_a("title").first.text
      title = element.elements["title"].text
      content = "###{title}\n" << element.elements["content:encoded"].text
      comments = (element.elements["wp:comment_status"].text.eql? "open") ? "true" : "false"

      categories = element.elements.each("category"){|element| element.text if element.attributes["domain"].eql? "category"}.compact.join(",")
      post_tags = element.elements.each("category"){|element| element.text if element.attributes["domain"].eql? "post_tag"}.compact.join(",")
      #puts element.children[1].text
      if element.elements["wp:post_date"].text.empty?
        date = DateTime.now
      else
        date = DateTime.parse element.elements["wp:post_date"].text
      end

      posts << {title: title, date: date, content: content, comments: comments, categories: categories}
      #create_new_post(title: title, date: date, content: content, comments: comments, categories: categories)
    end

    return posts
  else
    raise "### You haven't set date_file yet. or date_file not exists."
  end
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
def create_new_post(params = {})
  titile = params.delete(:tile)
  title ||= 'new-post'
  date  = params.delete(:date)
  comments  = params.delete(:comments)
  categories  = params.delete(:categories)

  puts "Begin a new post in #{source_dir}/#{posts_dir}"
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  puts "set posts_dir"
  `mkdir -p "#{source_dir}/#{posts_dir}"`

  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{date.strftime('%Y-%m-%d %H:%M')}"
    post.puts "comments: #{comments}"
    post.puts "categories: #{categories}"
    post.puts "---"
    post.puts "#{content}"
  end
end
