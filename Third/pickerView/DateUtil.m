//
//  DateUtil.m
//  myPassWordWallet
//
//  Created by 田原 on 14-2-23.
//  Copyright (c) 2014年 田原. All rights reserved.
//

#import "DateUtil.h"
static long long daySeconds = 60*60*24;
@implementation DateUtil

+(NSInteger)ageWithDateOfBirth:(NSDate *)date{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

+(NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

+(NSDate *)BirthdateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年MM月dd日"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}
+(NSString *)stringFromDate3:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M.dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)stringFromDate4:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+(NSString *)birthdayStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)startTimeStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)msgTimetoCurrent:(NSDate *)date{
    NSString *returnString;
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *today = [dateFormatter stringFromDate:[NSDate date]];
        NSString *msgday = [dateFormatter stringFromDate:date];
        NSTimeInterval secondsBetweenDates= [[NSDate date] timeIntervalSinceDate:date];
        if ([today isEqualToString:msgday]) {
            [dateFormatter setDateFormat:@"hh:mm:ss"];
            returnString = [dateFormatter stringFromDate:date];
        }else{
            if (secondsBetweenDates < daySeconds) {
                returnString = [[NSString alloc]initWithFormat:@"一天前"];
            }else if (secondsBetweenDates > daySeconds && secondsBetweenDates < daySeconds*2) {
                returnString = [[NSString alloc]initWithFormat:@"两天前"];
            }else{
                returnString = msgday;
            }
        }
    }
    @catch (NSException *exception) {
        returnString = Nil;
    }
    return returnString;
}
+(NSString*)ageFromBirthToNow:(NSDate*)birthday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *birthyear = [dateFormatter stringFromDate:birthday];
    NSString *thisyear = [dateFormatter stringFromDate:[NSDate date]];
    int age=[thisyear intValue]-[birthyear intValue];
    return [NSString stringWithFormat:@"%d岁",age];
}

+(NSString *)stringFromDate2:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDate5:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSInteger)numberOfTimeFromBetweenEndTime:(NSString *)endTime andStartTime:(NSString *)startTime {
    //    NSString *dateStr=@"2014-12-13 20:28:40";//传入时间
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:startTime];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //    NSLog(@"fromdate=%@",fromDate);
    //获取当前时间
    NSDateFormatter *format2=[[NSDateFormatter alloc] init];
    [format2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[format2 dateFromString:endTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: endDate];
    NSDate *localeDate = [endDate  dateByAddingTimeInterval: interval];
    //    NSLog(@"enddate=%@",localeDate);
    
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    
    long lTime = (long)intervalTime;
    //    NSInteger iSeconds = lTime % 60;
    NSInteger iHours = (lTime / 3600);

    //    NSLog(@"相差M%d年%d月 或者 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    return iHours;
}

+(NSInteger)numberOfSecondFromBetweenEndTime:(NSString *)endTime andStartTime:(NSString *)startTime
{
    //    NSString *dateStr=@"2014-12-13 20:28:40";//传入时间
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:startTime];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //    NSLog(@"fromdate=%@",fromDate);
    //获取当前时间
    NSDateFormatter *format2=[[NSDateFormatter alloc] init];
    [format2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[format2 dateFromString:endTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: endDate];
    NSDate *localeDate = [endDate  dateByAddingTimeInterval: interval];
    //    NSLog(@"enddate=%@",localeDate);
    
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    
    long lTime = (long)intervalTime;
    NSInteger iSeconds = lTime;
    
    //    NSLog(@"相差M%d年%d月 或者 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    return iSeconds;
}

//+(NSString *)distanceFromJobPoint:(double)lat Lon:(double)lon
//{
//    if (lat>0 && lon>0) {
//        
//        CLLocationCoordinate2D jobP=CLLocationCoordinate2DMake(lat, lon);
//        CLLocationCoordinate2D location=[AJLocationManager shareLocation].lastCoordinate;
//        NSNumber *disNumber=[MLMapManager calDistanceMeterWithPointA:jobP PointB:location];
//        int threshold=[disNumber intValue];
//        if (threshold >100000) {
//            return [NSString stringWithFormat:@">100km"];
//        }else if(threshold>1000)
//        {
//            return [NSString stringWithFormat:@"%.2fkm",[disNumber doubleValue]/1000];
//        }else if(threshold<1000&&threshold>0)
//        {
//            return [NSString stringWithFormat:@"%dm",threshold];
//        }
//        
//    }
//    return @"";
//    
//}


+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02d",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02d",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02d",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}

+(NSString *)dayTimeformatFromSeconds:(NSInteger)secondes
{
    // format of day
    NSString *str_day = [NSString stringWithFormat:@"%02d",secondes/(3600*24)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02d",secondes/3600-secondes/(3600*24)*24];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02d",(secondes%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02d",secondes%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@天%@小时%@分%@秒",str_day,str_hour,str_minute,str_second];
    return format_time;
}

+(NSString *)dateTimeFromINterval:(long)time withFormatter:(NSString *)formatterStyle
{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatterStyle];
    NSString *dateString = [dateFormat stringFromDate:nd];
    return dateString;
}


+ (NSString *)ConvertStrToTime:(NSNumber *)timeStr
{
    NSString *stringTime=timeStr.stringValue;
    long long time=[stringTime longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
}
+(NSString *)ConvertStrToTimeWithYeartoSecond:(NSNumber *)timeStr{
    NSString *stringTime=timeStr.stringValue;
    long long time=[stringTime longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;

}

@end
