//
//  YBToolModel.m
//  Demo_YB
//
//  Created by yan on 2018/7/8.
//  Copyright © 2018年 YB. All rights reserved.
//

#import "YBManager.h"


@implementation YBManager
static YBManager *ybToolModel = nil;

+ (instancetype)shared
{
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ybToolModel = [[YBManager alloc] init];
        });
    }
    return ybToolModel;
}

- (UIFont *)fontMain{
    return [UIFont systemFontOfSize:14];
}

- (UIColor *)colorBg{
    return [YBManager colorWith:0XF5F5F5];
}

-(UIColor *)colorLine{
    return [YBManager colorWith:0xf0f0f0];
}

-(UIColor *)colorFont{
    return [YBManager colorWith:0x26324E];
}

- (UIColor *)colorFontLight{
    return [YBManager colorWith:0xA7B1D1];
}

- (UIColor *)colorMain{
    return [YBManager colorWith:0xFFA029];
}

+(NSString*)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString*)getFormatedTime:(NSDate*)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:date];
    return dateTime;
    
}

+(NSString *)stringWithDate:(NSDate *)date Format:(nullable NSString *)fmt
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:fmt?:@"yyyy-MM-dd HH:mm"];
    
    return [df stringFromDate:date];
}

+(NSDate *)dateWithString:(NSString *)stringDate Format:(NSString *)fmt
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:fmt?:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df dateFromString:stringDate];
}

+(NSString *)countdownTimeFrom:(NSTimeInterval)ti
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 目标时间
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:ti];
    // 当前时间
    NSDate *today = [NSDate dateWithTimeIntervalSince1970:0];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算时间差
    NSDateComponents *d = [calendar components:unitFlags fromDate:targetDate toDate:today options:0];
    // 倒计时显示
    NSString *strDate = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",(long)[d day], (long)[d hour], (long)[d minute], (long)[d second]];
    strDate = [strDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return strDate;
}

+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

+(NSString *)getCurrentVersion
{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


+ (BOOL)ifThisADBannerHaveOnceShowed:(NSString *)md5
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"sawAdMd5%@",@"this is user id"]];
    return [array containsObject:md5];
}


+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+(void)callSomebody:(NSString *)tel
{
    if ([YBManager stringIsEmpty:tel]) {
        return;
    }
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
        if(success){
             NSLog(@"成功");
        } else {
             NSLog(@"失败");
        }
    }];
}

+ (BOOL)ifThisStringIsAnNumber:(NSString *)str
{
    if ([self isPureInt:str] || [self isPureFloat:str]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (void)resignFirstResponder
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

+ (UIWindow *)keyWindow
{
    return [[UIApplication sharedApplication].delegate window];
}

+ (void)bringViewToFrontAllTime:(UIView *)view
{
    view.layer.zPosition = MAXFLOAT;
    // 之后如果有View继续设置MAXFOAT，会更上层覆盖
    
}

+ (UIView *)duplicateView:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

+(void)moveForwardTopVC:(UIViewController *)vc ForwardIndex:(NSInteger)index
{
    // 直接操作nav的viewControllers栈
    NSMutableArray *stackAry=[NSMutableArray arrayWithArray:vc.navigationController.viewControllers];
    
    for (NSInteger i=vc.navigationController.viewControllers.count-1; i>=vc.navigationController.viewControllers.count-1-index; i--) {
        if(i<0) return;
        [stackAry removeObjectAtIndex:i];
    }
    [stackAry addObject:vc];
    vc.navigationController.viewControllers=[stackAry copy];
}

+(void)popToViewControllerWithVC:(UIViewController *)vc toClass:(Class)toClass animated:(BOOL)animated
{
    for (UIViewController *controller in vc.navigationController.viewControllers) {
        if ([controller isKindOfClass:toClass]) {
            [vc.navigationController popToViewController:controller animated:animated];
        }
    }
}

+(BOOL)currentStackisContainClass:(Class)className withCurrentVC:(UIViewController *)vc;
{
    BOOL flag = NO;
    UINavigationController *nav = vc.navigationController;
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:className]) {
            flag = YES;
            break;
        }
    }
    return flag;
}

+(void)moveForwardTopVC:(UIViewController *)vc ToIndex:(NSInteger)index  FormStackWithNavigationController:(UINavigationController *)nav
{
    NSMutableArray *stackAry=[NSMutableArray arrayWithArray:nav.viewControllers];
    
    for (NSInteger i=nav.viewControllers.count-1; i>=nav.viewControllers.count-1-index; i--) {
        if(i<0) return;
        [stackAry removeObjectAtIndex:i];
    }
    [stackAry addObject:vc];
    nav.viewControllers=[stackAry copy];
}

+(void)replaceOldVC:(UIViewController *)oldVC NewVC:(UIViewController *)newVC
{
    UINavigationController *nav = oldVC.navigationController;
    NSMutableArray *stackAry=[NSMutableArray arrayWithArray:nav.viewControllers];
    NSInteger index = [stackAry indexOfObject:oldVC];
    NSMutableArray *delArray = [NSMutableArray arrayWithObject:oldVC];
    [stackAry replaceObjectAtIndex:index withObject:newVC];
    nav.viewControllers = [stackAry copy];
    [delArray removeAllObjects];
}

+(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        NSString *type = ([dict[key] isKindOfClass:[NSNumber class]])?@"NSNumber":@"NSString";
        printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
    }
    printf("@end\n");
    
}


+ (float) calculateStrheightWithStr:(NSString *)str Font: (UIFont *)font Width: (float) width
{
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    
    return ceil(textRect.size.height);
}

+ (float) calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font
{
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    
    return ceil(textRect.size.width);
}

+ (void)changeViewToCircle:(UIView *)view
{
    view.layer.cornerRadius = view.bounds.size.width/2.0;
    view.clipsToBounds = YES;
}

+ (void)reloadCollectionViewHeight:(UICollectionView *)collectionView
{
    CGFloat x = collectionView.frame.origin.x;
    CGFloat y = collectionView.frame.origin.y;
    CGFloat width = collectionView.bounds.size.width;
    CGFloat height = collectionView.collectionViewLayout.collectionViewContentSize.height;
    collectionView.frame = CGRectMake(x, y, width, height);
}

+(NSAttributedString *)attributeTextStr:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont  keywordStr:(NSString *)keywordStr keywordColor:(UIColor *)keywordColor keywordFont:(UIFont *)keywordFont
{
    return [YBManager attributeTextStr:text textColor:textColor textFont:textFont keywordStrArray:keywordStr?@[keywordStr]:nil keywordColor:keywordColor keywordFont:keywordFont];
}

+(NSAttributedString *)attributeTextStr:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont keywordStrArray:(NSArray *)keywordStrArray keywordColor:(UIColor *)keywordColor keywordFont:(UIFont *)keywordFont
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr addAttributes:@{NSFontAttributeName:textFont?:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:textColor?:[UIColor blackColor]} range:NSMakeRange(0, text.length)];
    for (NSString *tempstr in keywordStrArray) {
        [attr addAttributes:@{NSFontAttributeName:keywordFont?:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:keywordColor?:[UIColor blackColor]} range:[text rangeOfString:tempstr]];
    }
    return attr;
}

/** Button Factory*/
+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor
{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor ? : [UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor ? :[UIColor whiteColor];
    return btn;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor CornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor ImageName:(NSString *)imageName
{
    UIButton *btn = [YBManager createButtonWithFrame:frame Title:title TitleColor:titleColor BackgroundColor:backgroundColor];
    btn.layer.cornerRadius  = cornerRadius;
    if (borderWidth > 0) {
        btn.layer.borderWidth=borderWidth;
    }
    if (borderColor) {
        btn.layer.borderColor=[borderColor CGColor];
    }
    btn.layer.masksToBounds=YES;
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    return btn;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame Text:(NSString *)text Font:(UIFont *) font TextColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text ? :@"";
    if (font) {
        label.font = font;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    return label;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame Text:(NSString *)text Font:(UIFont *) font TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor TextAlignment:(NSTextAlignment)textAlinment
{
    UILabel *label = [YBManager createLabelWithFrame:frame Text:text Font:font TextColor:textColor];
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    label.textAlignment = textAlinment;
    return label;
}

+(void)shareActionTitle:(NSString *)title andImageAderss:(NSString *)imageString andShareUrl:(NSString *)shareUrl controller:(UIViewController *)controller{
    
    //分享的标题
    NSString *textToShare = title;
    
    //分享的图片 //
    UIImage *imageToShare;
    if ([imageString hasPrefix:@"http"]) {
        imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
    }else{
        imageToShare = [UIImage imageNamed:imageString];
    }
    
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:shareUrl];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    
    //不出现在活动项目
    if (@available(iOS 9.0, *)) {
        activityVC.excludedActivityTypes = @[UIActivityTypePostToTwitter,UIActivityTypePostToFacebook,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypeAirDrop,UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeOpenInIBooks,];
    } else {
        // Fallback on earlier versions
    }
    [controller presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"分享 成功");
        } else  {
            NSLog(@"分享 取消");
        }
    };
    
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


/**
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color{
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

+ (NSArray *)bubbleSort:(NSMutableArray *)array{
    NSInteger i,j;
    NSInteger n = array.count;
    BOOL flag = YES;
    for (i = 0; i<n&&flag; i++) {
        flag = NO;
        for (j = n -1; j>i; j--) {
            if ([array[j] integerValue] < [array[j-1] integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                flag = YES;
            }
        }
    }
    return array;
}

+(NSString *)getNowTimeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这一点对时间的处理很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
        NSDate *dateNow = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];
    return timeStamp;
}



+ (NSString *_Nullable)getTimeSp{
    NSString *resultString = nil;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] ;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHMMss"];
    NSDate *datenow = [NSDate dateWithTimeIntervalSince1970:time];
    resultString = [formatter stringFromDate:datenow];
    return resultString;
}


+(BOOL)stringIsEmpty:(id _Nonnull )object{
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqualToString:@""]) {
        return YES;
    }
    
    if ([NSString stringWithFormat:@"%@",object].length == 0) {
        return YES;
    }
    
    if ([object isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if (object == nil) {
        return YES;
    }
    return NO;
}
+(NSString *)GstringIsEmpty:(id _Nonnull)object {
    if (![YBManager stringIsEmpty:object]) {
        return object;
    } else {
        return @"";
    }
}
/// 添加四边阴影效果
+(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor{
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}

-(void)requiredRandomCode:(myBlock _Nullable )block{
    if (block) {
        block(@"123");
    }
}

+(NSString *_Nullable)getCurrentMonth{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |

    NSCalendarUnitMonth | NSCalendarUnitDay |

    NSCalendarUnitHour | NSCalendarUnitMinute |

    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    return [NSString stringWithFormat:@"%ld",comp.month];
}


/// 获取当前年份
+(NSString *_Nullable)getCurrentYear{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *thisYearString=[dateformatter stringFromDate:senddate];
    return thisYearString;
}


+(NSString *_Nullable)getStringWithNSNumberFor:(CGFloat)myValue{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *valueSring = [format stringFromNumber:[NSNumber numberWithDouble:myValue]];
    return valueSring;
}

+(NSString *)transformTime:(NSInteger)count{
     NSInteger hour = count / 3600;
     NSInteger min = (count - hour * 3600) / 60;
     NSInteger sec = count - hour * 3600 - min * 60;
     NSString * time = [NSString stringWithFormat:@"%.2zd:%.2zd:%.2zd",hour,min,sec];
     return time;
}

+(UIColor *)colorWith:(NSInteger)hex{
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 8*2)/255.0
                              green:((hex & 0x00FF00) >> 8*1)/255.0
                               blue:((hex & 0x0000FF) >> 8*0)/255.0
                              alpha:1.0];
}
@end
