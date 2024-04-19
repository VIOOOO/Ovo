本地运行修改Scss需要安装依赖；
方法1：
	在vscode扩展中分别搜索并安装：Sass 和 EasySass。
	打开设置找到setting.json,将下面的代码复制粘贴到setting.json文件中保存即可。
	
		"files.associations": {
			"*.css":"scss"
		},
		"easysass.compileAfterSave": true,
		"easysass.excludeRegex": "_",
		//css生成路径
		"easysass.formats": [
			{
				"format": "expanded",
				"extension": ".css"
			},
			{
				"format": "compressed",
				"extension": ".min.css"
			}
		]
		
	编辑index.scss文件并保存，会自动生成index.min.css和index.css 这两个文件在当前文件。
	
	
方法2：
	安装 sass，推荐全局安装
	npm install sass -g
	
	执行命令 指定文件 cssDemo.scss 编译到 static/css/ 路径下的 cssDemo.css 文件
	npx sass  cssDemo.scss  static/css/cssDemo.css
	
	当完成 scss 文件编译完成，执行命令能自动进行编译，当修改时也会自动编译：
	npx sass --watch  cssDemo.scss  static/css/cssDemo.css
	
	运行自动编译文件后会生成一个 map 文件，如不需要可以执行命令：
	npx sass --watch  cssDemo.scss  static/css/cssDemo.css --no-source-map
	
	