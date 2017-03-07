//
//  DateUtil.h
//  myPassWordWallet
//
//  Created by 田原 on 14-2-23.
//  Copyright (c) 2014年 田原. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject
+(NSInteger)ageWithDateOfBirth:(NSDate *)date;
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSString *)stringFromDate:(NSDate *)date;
+(NSString *)birthdayStringFromDate:(NSDate *)date;
+(NSString *)startTimeStringFromDate:(NSDate *)date;
+(NSString *)msgTimetoCurrent:(NSDate *)date;
+(NSDate *)BirthdateFromString:(NSString *)dateString;
+ (NSString*)ageFromBirthToNow:(NSDate*)birthday;
+(NSString *)stringFromDate2:(NSDate *)date;
+(NSString *)stringFromDate3:(NSDate *)date;
+(NSString *)stringFromDate4:(NSDate *)date;
+(NSString *)stringFromDate5:(NSDate *)date;
+(NSInteger)numberOfTimeFromBetweenEndTime:(NSString *)endTime andStartTime:(NSString *)startTime; // 小时差
+(NSInteger)numberOfSecondFromBetweenEndTime:(NSString *)endTime andStartTime:(NSString *)startTime;// 秒差
+(NSString *)distanceFromJobPoint:(double)lat Lon:(double)lon;
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds;
+(NSString *)dayTimeformatFromSeconds:(NSInteger)secondes;
+(NSString *)dateTimeFromINterval:(long)time withFormatter:(NSString *)formatterStyle;
+ (NSString *)ConvertStrToTime:(NSNumber *)timeStr;//将毫秒转成时间格式

+ (NSString *)ConvertStrToTimeWithYeartoSecond:(NSNumber *)timeStr;//将毫秒转成时间格式

@end
