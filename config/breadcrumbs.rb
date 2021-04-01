crumb :root do
  link "Home", root_path
end

crumb :item_new do
  link "商品出品", new_item_path
  parent :root
end

crumb :item_show do |item|
  if params[:id] == nil
    item = Item.find(params[:item_id])
  else
    item = Item.find(params[:id])
  end
  link "商品詳細", item_path(item)
  parent :root
end

crumb :item_edit do
  link "商品編集", item_path
  parent :item_show
end

crumb :item_destroy do
  link "商品削除確認", item_path
  parent :item_show
end

crumb :item_order do |order|
  order = Item.find(params[:item_id])
  link "商品購入", item_orders_path(order)
  parent :item_show
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