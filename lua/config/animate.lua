local is_termux = (os.getenv('PREFIX') or ''):find('com.termux')
if not is_termux then
	local ok, animate = pcall(require, 'mini.animate')
	if ok then
		animate.setup({})
	end
end

