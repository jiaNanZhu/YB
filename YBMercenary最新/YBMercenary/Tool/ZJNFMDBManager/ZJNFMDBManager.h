//
//  ZJNFMDBManager.h
//  OverseasRealEstateProject
//
//  Created by 险峰科技 on 2018/6/13.
//  Copyright © 2018年 XianFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ZJNFMDBManager : NSObject

+(ZJNFMDBManager *)sharedInstance;

/**
 添加搜索字段到本地数据库

 @param searchText 需要添加的字段
 */
-(void)addSearchTextWithSearchText:(NSString *)searchText;

/**
 删除所有缓存记录
 */
-(void)deleteAllSearchText;

/**
 获取所有的缓存记录

 @return 返回本地存储的缓存记录
 */
-(NSArray *)getAllSearchText;
///**
// 添加搜索字段
//
// @param searchText 搜索字段
// */
//-(void)addSearchTextWithModel:(NSString *)searchText;
///**
// 删除某个分类下的某一条搜索记录
//
// @param searchText 搜索记录
// */
//-(void)deleteSearchTextWithModel:(NSString *)searchText;
///**
// 删除某一分类下所有的搜索记录
//
// @param hType 根据hType删除数据
// */
//-(void)deleteAllSearchTextWithHType:(NSString *)hType;
///**
// 删除租房和商业地产下小分类的搜索记录
//
// @param hType 租房 商业地产
// @param shType 小分类
// */
//-(void)deleteCategorySearchTextWithHType:(NSString *)hType shType:(NSString *)shType;
///**
// 获取详细的某一分类下的搜索字段
//
// @param hType hType
// @param shType shType
// @return 搜索字段数组
// */
//-(NSArray *)getSearchTextsWithHType:(NSString *)hType shType:(NSString *)shType;
///**
// 获取大分类下 例如租房下所有小分类的搜索字段
//
// @param hType hType
// @return 搜索字段数组
// */
//-(NSArray *)getSearchTexts;
@end
