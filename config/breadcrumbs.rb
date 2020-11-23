crumb :root do
  link "HOMEボード", app_tops_path
end

crumb :new_property do
  link "物件登録", new_property_path
  parent :root
end

crumb :index_property do
  link "物件一覧", sort_property_path
  parent :root
end

crumb :show_property do
  link "物件詳細", property_path(params[:id])
  parent :index_property
end

crumb :new_room do
  link "部屋登録", room_path
  parent :show_property
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).