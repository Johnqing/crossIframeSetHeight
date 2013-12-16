跨域iframe高度自适应
====================

注意：第三方域必须可控（因为要在第三方域中引入js）

## 需要准备内容
1. parent.html（根页面）
2. proxy.html（直接复制本项目下的代码即可）
3. 引入的第三方页面

确保 parent.html和proxy.html在同一个域下

## 使用

1. 在parent.html引入第三方页面
2. 在第三方页面中尾部写入
```
<script src="http://liuqing.pw/crossIframeSetHeight/crossIframeProxy.js" data-frameid="test" data-timer="500" data-proxy="http://liuqing.pw/crossIframeSetHeight/proxy.html"></script>
```
