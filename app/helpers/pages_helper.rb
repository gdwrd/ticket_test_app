module PagesHelper
  def header_link path, path_name
    classes = "active" if request.env["PATH_INFO"] == path
    render inline: "<li class=#{classes}>#{link_to path_name, path}</li>"
  end
end
