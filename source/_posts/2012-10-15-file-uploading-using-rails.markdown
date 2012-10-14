---
layout: post
title: "File Uploading using Rails"
date: 2011-12-20 15:55
comments: true
categories: [rails,ruby]
tags: [file,rails,ruby,upload]
---
## File Uploading using Rails
You may have a requirement in which you want your site visitors to upload a file on your server. Rails makes it very easy to handle this requirement. Now we will proceed with a simple and small Rails project.

As usual, let's start off with a new Rails application called <strong>upload</strong>. So let's create basic structure of the application by using simple rails command.
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>C:\ruby&gt; rails upload</pre>
</td>
</tr>
</tbody>
</table>
Now let's decide where you would like to save your uploaded files. Assume this is <strong>data</strong> directory inside your public section. So create this directory and check the permissions.
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>C:\ruby&gt; cd upload
C:\ruby&gt; mkdir upload\public\data</pre>
</td>
</tr>
</tbody>
</table>
Our next step will be as usual, to create controller and models, so let's do that:
<h2>Creating Model:</h2>
Because this is not a database based application so we can keep name whatever is comfortable to us. Assume we have to create a <strong>DataFile</strong> model.
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>C:\ruby&gt; ruby script/generate model DataFile
      exists  app/models/
      exists  test/unit/
      exists  test/fixtures/
      create  app/models/data_file.rb
      create  test/unit/data_file_test.rb
      create  test/fixtures/data_files.yml
      create  db/migrate
      create  db/migrate/001_create_data_files.rb</pre>
</td>
</tr>
</tbody>
</table>
Now we will create a method called <strong>save</strong> in <strong>data_file.rb</strong> model file. This method will be called by the application controller.
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>class DataFile &lt; ActiveRecord::Base
  def self.save(upload)
    name =  upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
end</pre>
</td>
</tr>
</tbody>
</table>
The above function will take CGI object <strong>upload</strong> and will extract uploaded file name using helper function <strong>original_filename</strong> and finally it will store uploaded file into "public/data" directory. You can call helper function <strong>content_type</strong> to know media type of the uploaded file.

Here <strong>File</strong> is a ruby object and join is a helper function will concatenate directory name alongwith file name and will return full file path.

Next, to open a file in write mode we are using open helper function provided by <strong>File</strong> object. Further we are reading data from the passed data file and writing into output file.
<h2>Creating Controller:</h2>
Now let's create a controller for our upload project:
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>C:\ruby&gt; ruby script/generate controller Upload
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/upload
      exists  test/functional/
      create  app/controllers/upload_controller.rb
      create  test/functional/upload_controller_test.rb
      create  app/helpers/upload_helper.rb</pre>
</td>
</tr>
</tbody>
</table>
Now we will create two controller functions first function <strong>index</strong> will call a view file to take user input and second function <strong>uploadFile</strong> takes file information from the user and passes it to the 'DataFile' model. We set the upload directory to the 'uploads' directory we created earlier "directory = 'data'".
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>class UploadController &lt; ApplicationController
  def index
     render :file =&gt; 'app\views\upload\uploadfile.rhtml'
  end
  def uploadFile
    post = DataFile.save(params[:upload])
    render :text =&gt; "File has been uploaded successfully"
  end
end</pre>
</td>
</tr>
</tbody>
</table>
Here we are calling function defined in model file. The <strong>render</strong> function is being used to redirect to view file as well as to display a message.
<h2>Creating View:</h2>
Finally we will create a view file <strong>uploadfile.rhtml</strong> which we have mentioned in controller. Populate this file with the following code:
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>&lt;h1&gt;File Upload&lt;/h1&gt;
&lt;%= start_form_tag ({:action =&gt; 'uploadFile'}, 
                        :multipart =&gt; true) %&gt;
&lt;p&gt;&lt;label for="upload_file"&gt;Select File&lt;/label&gt; : 
&lt;%= file_field 'upload', 'datafile' %&gt;&lt;/p&gt;
&lt;%= submit_tag "Upload" %&gt;
&lt;%= end_form_tag %&gt;</pre>
</td>
</tr>
</tbody>
</table>
Here everything is same what we have explained in earlier chapters. Only new tag is <strong>file_field</strong> which will create a button to select a file from user's computer.

By setting the multipart parameter to true, you ensure that your action properly passes along the binary data from the file.

Here, an important point to note is that we have assigned <strong>"uploadFile"</strong> as the method name in :action, which will be called when you click the <strong>Upload</strong> button.

This will show you a screen as follows:

<center><img src="http://www.tutorialspoint.com/images/upload-file.gif" alt="Upload File" />

</center>Now you select a file and upload it, this file will be uploaded into app/public/data directory with the actual file name and a message will be displayed to you saying that "File has been uploaded successfully".

<strong>NOTE:</strong> If a file with the same name already exists in your output directory then it will be over-written.
<h2>Files uploaded from Internet Explorer:</h2>
Internet Explorer includes the entire path of a file in the filename sent, so the <strong>original_filename</strong> routine will return something like:
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>C:\Documents and Files\user_name\Pictures\My File.jpg</pre>
</td>
</tr>
</tbody>
</table>
instead of just:
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>My File.jpg</pre>
</td>
</tr>
</tbody>
</table>
This is easily handled by <strong>File.basename</strong>, which strips out everything before the filename.
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>def sanitize_filename(file_name)
  # get only the filename, not the whole path (from IE)
  just_filename = File.basename(file_name) 
  # replace all none alphanumeric, underscore or perioids
  # with underscore
  just_filename.sub(/[^\w\.\-]/,'_') 
end</pre>
</td>
</tr>
</tbody>
</table>
<h2>Deleting an existing File:</h2>
If you want to delete any existing file then its simple and need to write following code:
<table cellpadding="5">
<tbody>
<tr>
<td>
<pre>  def cleanup
    File.delete("#{RAILS_ROOT}/dirname/#{@filename}") 
            if File.exist?("#{RAILS_ROOT}/dirname/#{@filename}")
  end</pre>
</td>
</tr>
</tbody>
</table>
For a complete detail on <strong>File</strong> object, you need to go through Ruby Reference Manual.
