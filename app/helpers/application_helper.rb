module ApplicationHelper

	def active_admin_links(path)
		path_name = "#{controller_name.to_s}-#{action_name}" 
		return path_name.match(path) ? 'active' : '' 
	end
end
