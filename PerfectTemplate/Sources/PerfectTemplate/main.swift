//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer


let myServer = MyServer.init(root: "/Users/admin/Desktop/PerfectTemplate/Sources/file", port: 8181)

myServer.start()



// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
//func handler(request: HTTPRequest, response: HTTPResponse) {
//    // Respond with a simple message.
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
//    // Ensure that response.completed() is called when your processing is done.
//    response.completed()
//}
//
//// 配置路由，客户端的请求将会在这里被处理
//var routes = Routes()
//
//// get请求，将会返回html
//routes.add(method: .get, uri: "/", handler: handler)
//
//// 提供静态文件，设置 documentRoot 路径后，目录下所有的文件都是可以被请求获取到的
//// 现在如果这样设置路径，通过请求http://localhost:8181/xxx 将会获取本地Sources目录下的xxx文件
//routes.add(method: .get, uri: "/**",
//           handler: StaticFileHandler(documentRoot: "/Users/admin/Desktop/PerfectTemplate/Sources", allowResponseFilters: true).handleRequest)
//
//// 本地启动一个服务，端口是8181
//try HTTPServer.launch(name: "localhost",
//                      port: 8181,
//                      routes: routes,
//                      responseFilters: [
//                        (PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])

