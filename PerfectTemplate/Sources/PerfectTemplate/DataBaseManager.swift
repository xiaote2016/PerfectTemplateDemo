//
//  DataBaseManager.swift
//  COpenSSL
//
//  Created by xiete@wyc.cn on 2018/10/16.
//

import Foundation
import PerfectMySQL

//MARK: 数据库信息
// XieteProject
let mysql_host = "localhost"
let mysql_user = "root"
let mysql_password = "********" // (记得改为自己的数据库密码)
let mysql_database = "XieteProject"

//MARK: 表信息
let table_column = "tbl_column"

let dbManager = DataBaseManager.init()
open class DataBaseManager {
    
    
    fileprivate var mysql : MySQL
    internal init(){
        
        mysql = MySQL.init()  // 创建MySQL对象
        
        //设置客户端字符集，这是非常必要的操作，否则所有中文可能都会变成问号
        guard mysql.setOption(.MYSQL_SET_CHARSET_NAME, "utf8mb4") else {
            return
        }
        
        guard connectedDataBase() else {  // 开启MySQL连接
            return
        }
    }
    
    // MARK: 开启连接
    private func connectedDataBase() -> Bool{
        let connected = mysql.connect(host: mysql_host, user: mysql_user, password: mysql_password, db: mysql_database)
        
        guard connected else {
            
            print("MySQL连接失败" + mysql.errorMessage())
            return false
        }
        print("MySQL连接成功")
        return true
    }
    
    
    
    //MARK: 执行SQL语句
    /// 执行SQL语句
    ///
    /// - Parameter sql: sql语句
    /// - Returns: 元组
    @discardableResult
    func mysqlStatement(_ sql : String) -> (success : Bool, mysqlResult : MySQL.Results?, errorMsg: String){
        
        guard mysql.selectDatabase(named: mysql_database) else {
            
            let msg = "未找到\(mysql_database)数据库:\(mysql.errorMessage())"
            print(msg)
            
            return (false, nil, msg)
        }
        
        let successQuery = mysql.query(statement: sql)
        guard successQuery else {
            
            let msg = "SQL失败 ：\(sql)"
            print(msg)
            
            return(false, nil, msg)
        }
        
        let msg = "SQL成功 ：\(sql)"
        print(msg)
        return(true, mysql.storeResults(),msg)
    }
    
    
    /// 增
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键  （键，键，键）
    ///   - value: 值  ('值', '值', '值')
    /// - Returns: 元组
    func insertDatabaseSQL(tableName : String, key : String, value : String) -> (success : Bool, mysqlResult : MySQL.Results?, errorMsg: String){
        
        let SQL = "INSERT INTO \(tableName) (\(key)) VALUES (\(value))"
        
        return mysqlStatement(SQL)
    }
    
    /// 删
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    ///   - value: 值
    func deleteDatabaseSQL(tableName: String, key: String, value: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "DELETE FROM \(tableName) WHERE \(key) = '\(value)'"
        return mysqlStatement(SQL)
        
    }
    
    /// 改
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对( 键='值', 键='值', 键='值' )
    ///   - whereKey: 查找key
    ///   - whereValue: 查找value
    func updateDatabaseSQL(tableName: String, keyValue: String, whereKey: String, whereValue: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "UPDATE \(tableName) SET \(keyValue) WHERE \(whereKey) = '\(whereValue)'"
        return mysqlStatement(SQL)
        
    }
    
    
    /// 查所有
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    func selectAllDatabaseSQL(tableName: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "SELECT * FROM \(tableName)"
        return mysqlStatement(SQL)
        
    }
    
    /// 查
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对
    func selectAllDataBaseSQLwhere(tableName: String, keyValue: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        let SQL = "SELECT * FROM \(tableName) WHERE \(keyValue)"
        return mysqlStatement(SQL)
        
    }
    
    
}
