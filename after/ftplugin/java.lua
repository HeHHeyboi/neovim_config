local config = {
	cmd = { 'C:/Users/thana/AppData/Local/nvim-data/mason/bin/jdtls.cmd' },
	root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', 'gradlew', '.git', 'mvnw', '.classpath' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
