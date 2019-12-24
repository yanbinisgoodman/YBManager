//
//  YBToolModel.h
//  Demo_YB
//
//  Created by yan on 2018/7/8.
//  Copyright © 2018年 YB. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//屏幕长宽
#define YBScreenWidth [UIScreen mainScreen].bounds.size.width
#define YBScreenHeight [UIScreen mainScreen].bounds.size.height
#define YBWidthRate KUIScreenWidth/375
#define YBHeightRate KUIScreenHeight/667

//定义block
typedef void (^myBlock)(NSString * _Nonnull random);


@interface YBManager : NSObject
/************************Tools***********************/

+ (instancetype _Nullable )shared;

/// 主要字体大小
@property (nonatomic,strong) UIFont  * _Nullable fontMain;
/// 主要字体颜色
@property (nonatomic,strong) UIColor * _Nullable colorFont;

/// 浅色字体
@property (nonatomic,strong) UIColor * _Nullable colorFontLight;

/// 主题颜色
@property (nonatomic,strong) UIColor * _Nullable colorMain;

/// 背景颜色
@property (nonatomic,strong) UIColor * _Nullable colorBg;

/// 横线颜色
@property (nonatomic,strong) UIColor * _Nullable colorLine;




/**获取当前时间*/
+ (NSString *_Nullable)getCurrentTime;


/// 获取当前月份
+(NSString *_Nullable)getCurrentMonth;


/// 获取当前时间戳
+(NSString *_Nullable)getNowTimeStamp;

/// 获取当前年份
+(NSString *_Nullable)getCurrentYear;

/**将日期格式转化成字符串*/
+(NSString*_Nullable)getFormatedTime:(NSDate*_Nullable)date;

/** date->string*/
+(NSString *_Nullable)stringWithDate:(NSDate *_Nullable)date Format:(nullable NSString *)fmt;

/** string->date*/
+(NSDate *_Nullable)dateWithString:(NSString *_Nullable)stringDate Format:(NSString *_Nullable)fmt;

/** 将总秒数转换成 x天x小时x分钟x秒*/
+(NSString *_Nullable)countdownTimeFrom:(NSTimeInterval)ti;

/** 两个nsdate相差的天数*/
+(NSInteger)getDaysFrom:(NSDate *_Nullable)serverDate To:(NSDate *_Nullable)endDate;

/** 当前版本号*/
+(NSString *_Nullable)getCurrentVersion;

/** 判断这个ad在此用户是否显示过(uid + md5 判断)*/
+ (BOOL)ifThisADBannerHaveOnceShowed:(NSString *_Nullable)md5;

/** 改变图片大小*/
+(UIImage *_Nullable)reSizeImage:(UIImage *_Nullable)image toSize:(CGSize)reSize;

/** 拨打电话*/
+ (void)callSomebody:(NSString *_Nullable)tel;

/** 字符串是否为数字*/
+ (BOOL)ifThisStringIsAnNumber:(NSString *_Nullable)str;

/** 字符串是否为整形*/
+ (BOOL)isPureInt:(NSString*_Nullable)string;

/** 判断是否为浮点形*/
+ (BOOL)isPureFloat:(NSString*_Nullable)string;

/** 关闭所有键盘*/
+ (void)resignFirstResponder;

/** keyWindow*/
+ (UIWindow *_Nullable)keyWindow;

/** view层级设置最上*/
+ (void)bringViewToFrontAllTime:(UIView *_Nullable)view;

/** 复制视图*/
+ (UIView *_Nullable)duplicateView:(UIView*_Nullable)view;

/** vc栈*/

/** 从栈中将要移动vc向前移动index个位置，中间的vc将被释放*/
+ (void)moveForwardTopVC:(UIViewController *_Nullable)vc ForwardIndex:(NSInteger)index;

/** pop到指定名字的VC,没有index可能变化的引起的问题*/
+ (void)popToViewControllerWithVC:(UIViewController *_Nullable)vc toClass:(Class _Nullable )toClass animated:(BOOL)animated;

/** 当前栈中是否含有 class 这个类的实例存在*/
+(BOOL)currentStackisContainClass:(Class _Nullable )className withCurrentVC:(UIViewController *_Nullable)vc;

/** 从栈中移动vc 到指定序号*/
+(void)moveForwardTopVC:(UIViewController *_Nullable)vc ToIndex:(NSInteger)index  FormStackWithNavigationController:(UINavigationController *_Nullable)nav;

/** 从oldVC的栈中 ，使用newVC 替换 oldVC*/
+(void)replaceOldVC:(UIViewController *_Nullable)oldVC NewVC:(UIViewController *_Nonnull)newVC;


/** 传入数据字典&Model名打印出Model Body*/
+(void)createModelWithDictionary:(NSDictionary *_Nullable)dict modelName:(NSString *_Nullable)modelName;

/** 计算字符串高度*/
+ (float) calculateStrheightWithStr:(NSString *_Nullable)str Font: (UIFont *_Nullable)font Width: (float) width;

/** 计算字符串宽度*/
+ (float) calculateStrwidthWithStr:(NSString *_Nullable)str Font: (UIFont *_Nullable) font;

/** 将一个UIView切成圆形 宽高得相等*/
+ (void)changeViewToCircle:(UIView *_Nullable)view;

/** collectionView 重新加载数据后计算出高度并更新*/
+ (void)reloadCollectionViewHeight:(UICollectionView *_Nullable)collectionView;


/** 创建btn 基本属性: frame title titleColor backgroundColor*/
+ (UIButton *_Nullable)createButtonWithFrame:(CGRect)frame Title:(NSString *_Nullable)title TitleColor:(UIColor *_Nullable)titleColor BackgroundColor:(UIColor *_Nullable)backgroundColor;

/** 创建btn 基本属性 + 边框 + 圆角 + 背景图*/
+ (UIButton *_Nullable)createButtonWithFrame:(CGRect)frame Title:(NSString *_Nullable)title TitleColor:(UIColor *_Nullable)titleColor BackgroundColor:(UIColor *_Nullable)backgroundColor CornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *_Nullable)borderColor ImageName:(NSString *_Nullable)imageName;

/** 创建label 基本属性 frame text font textColor*/
+ (UILabel *_Nullable)createLabelWithFrame:(CGRect)frame Text:(NSString *_Nullable)text Font:(UIFont *_Nullable) font TextColor:(UIColor *_Nullable)textColor;

/** 创建label 基本属性 + backgroundColor + textAlinment*/
+ (UILabel *_Nullable)createLabelWithFrame:(CGRect)frame Text:(NSString *_Nullable)text Font:(UIFont *_Nullable) font TextColor:(UIColor *_Nullable)textColor BackgroundColor:(UIColor *_Nullable)backgroundColor TextAlignment:(NSTextAlignment)textAlinment;

/** 富文本单个keyword*/
+(NSAttributedString *_Nullable)attributeTextStr:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor textFont:(UIFont *_Nullable)textFont  keywordStr:(NSString *_Nullable)keywordStr keywordColor:(UIColor *_Nullable)keywordColor keywordFont:(UIFont *_Nullable)keywordFont;

/** 富文本多个keyword*/
+(NSAttributedString *_Nullable)attributeTextStr:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor textFont:(UIFont *_Nullable)textFont keywordStrArray:(NSArray *_Nullable)keywordStrArray keywordColor:(UIColor *_Nullable)keywordColor keywordFont:(UIFont *_Nullable)keywordFont;

/** 系统分享*/
+(void)shareActionTitle:(NSString *_Nullable)title andImageAderss:(NSString *_Nullable)imageString andShareUrl:(NSString *_Nullable)shareUrl controller:(UIViewController *_Nullable)controller;

/**验证身份证号码*/
+ (BOOL)validateIdentityCard:(NSString *_Nonnull)identityCard;

/**绘制虚线
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *_Nullable)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *_Nullable)color;

/** 数组排序算法*/
+ (NSArray *_Nullable)bubbleSort:(NSMutableArray *_Nullable)array;



/**
 签名时间方法

 @return <#return value description#>
 */
+ (NSString *_Nullable)getTimeSp;


/**
 判断字符串是否为空

 @param object <#object description#>
 @return <#return value description#>
 */
+(BOOL)stringIsEmpty:(id _Nonnull)object;


/**
 不负责返回不为null字符串

 @param object <#object description#>
 @return <#return value description#>
 */
+(NSString *_Nullable)GstringIsEmpty:(id _Nonnull)object;


-(void)requiredRandomCode:(myBlock _Nullable )block;


/// 添加阴影
/// @param theView <#theView description#>
/// @param theColor <#theColor description#>
+(void)addShadowToView:(UIView *_Nullable)theView withColor:(UIColor *_Nullable)theColor;


/// 取数据原型的值 防止数据异常
/// @param myValue <#floatValue description#>
+(NSString *_Nullable)getStringWithNSNumberFor:(CGFloat)myValue;


/// 时间转化  时间秒数转化成-> 00:00:00
/// @param count <#count description#>
+(NSString *_Nullable)transformTime:(NSInteger)count;


/// 获取颜色
/// @param hex <#hex description#>
+(UIColor *_Nonnull)colorWith:(NSInteger)hex;
@end
