//
//  WXCondition.h
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 08.11.15.
//

@import UIKit;
@import Foundation;

@interface WXCondition : NSObject

@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *tempHigh;
@property (nonatomic, strong) NSNumber *tempLow;
@property (nonatomic, strong) NSNumber *windBearing;
@property (nonatomic, strong) NSNumber *windSpeed;

@property (nonatomic, strong) NSDate *sunrise;
@property (nonatomic, strong) NSDate *sunset;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *locationName;
@property (nonatomic, copy) NSString *conditionDescription;
@property (nonatomic, copy) NSString *condition;

@property (nonatomic, strong) NSArray *weather;

- (NSString *)imageName;

@end
