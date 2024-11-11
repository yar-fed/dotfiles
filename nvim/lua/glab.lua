local A = vim.api

local M = {}


M.toqflist = function(notes)
	local list = {}
	for _, note in ipairs(notes) do
		if note.resolvable == true and note.resolved == false then
			local item = {
				filename = note.position.new_path,
				lnum = note.position.new_line,
				text = note.body,
				type = 'E',
			}
			table.insert(list, item)
		end
	end
	table.sort(list, function(a, b)
		if a.filename == b.filename then
			return a.lnum < b.lnum
		else
			return a.filename < b.filename
		end
	end)
	return list
end

M.set = function (mr)
	local repo = 'portal-ua.globallogic.com/gitlab'
	local project = 'ui-qos%2Ftcppep'
	local token = 'cGnoYPcsR-9FrWjz4Vb6'
	local tb = {}
	local pipe = io.popen(string.format('curl -s -i --header "PRIVATE-TOKEN: %s" "https://%s/api/v4/projects/%s/merge_requests/%d/notes"', token, repo, project, mr))
	local s = pipe:read('*a')
	pipe:close()
	local _, _, page_num = string.find(s, "X%-Total%-Pages: (%d)")
	print(page_num)
	for page=1,page_num do
		local pipe = io.popen(string.format('curl -s --header "PRIVATE-TOKEN: %s" "https://%s/api/v4/projects/%s/merge_requests/%d/notes?page=%d"', token, repo, project, mr, page))
		local page_content = pipe:read('*a')
		pipe:close()
		for k,v in pairs(vim.json.decode(page_content)) do table.insert(tb, v) end
	end
	local items = M.toqflist(tb)
	vim.fn.setqflist({}, ' ', { title = 'MR notes', items = items })
	return
end
-- ╰

return M
