local function jdtls_exe()
	local path = "jdtls"
	if vim.uv.os_uname().sysname == "Windows_NT" then
		path = "C:/Users/thana/AppData/Local/nvim-data/mason/bin/jdtls.cmd"
	end
	return { path }
end

local function root_dir()
	local file = vim.fs.find({ 'pom.xml', 'gradlew', '.git', 'mvnw', '.classpath' }, { upward = true })
	local root = vim.fs.dirname(file[1])
	print(root)
	return root
end

local config = {
	cmd = jdtls_exe(),
	root_dir = root_dir()
}
require('jdtls').start_or_attach(config)
