window = this
doc = window.document
body = doc.body

# 私有方法
# 创建iframe
ctFrame = ->
	el = doc.createElement 'iframe'
	el.style.display = 'none'
	el.name = 'qPay-proxy'
	return el
# 事件绑定
onBind = (evType, callback) ->
	if doc.addEventListener
		window.addEventListener evType, callback, false
		return
	window.attachEvent "on#{evType}", callback
	return

# 获取地址栏中的参数
getReq = (param) ->
	rgx = new RegExp '(^|&)'+name+'=([^&]*)(&|$)','i'
	regArr = window.location.search.substr(1).match rgx
	return if regArr != null then unescape(regArr[2]) else null
# 配置文件获取
scripts = doc.getElementsByTagName 'script'
scriptNode = scripts[scripts.length - 1]
getConf = (param) ->
	pm = scriptNode.getAttribute param
	return if pm then pm else getReq(param)



IframeProxy = ->
	@height = 0
	# 第三方域id
	@frameId = getConf 'data-frameid'
	# 更新间隔
	@time = getConf 'data-time'
	# 获取代理地址
	@proxyPath = getConf 'data-proxy'
	# 创建代理iframe
	@proxyIframe = ctFrame()
	return

IframeProxy:: =
	init: ->
		self = @

		_init = ->
			body.appendChild self.proxyIframe
			self.reSetHeight()
			# 如果有值就自动更新
			if self.time
				self.time = if self.time<500 then 500 else self.time
				window.setInterval ->
					if body.offsetHeight != self.height
						self.reSetHeight()
				, self.time

		onBind 'load', _init
	###
	* 重设高度
	###
	reSetHeight: ->
		self = @
		self.height = body.offsetHeight
		self.proxyIframe.src = self.proxyPath + '?data-frameid=' + self.frameId + '&data-frameheight=' + (self.height+40)
		return
(new IframeProxy()).init()