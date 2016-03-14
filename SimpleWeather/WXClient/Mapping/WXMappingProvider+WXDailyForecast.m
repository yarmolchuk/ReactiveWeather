//
//  WXMappingProvider+WXDailyForecast.m
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 10.11.15.
//

#import "WXMappingProvider+WXDailyForecast.h"
#import "WXDailyForecast.h"

@implementation WXMappingProvider (WXDailyForecast)

+ (FEMMapping *)dailyForecastMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[WXDailyForecast class]];
    
    [mapping addAttributeWithProperty:@"date" keyPath:@"dt"];
    [mapping addAttributeWithProperty:@"temperature" keyPath:@"temp.day"];
    [mapping addAttributeWithProperty:@"tempHigh" keyPath:@"temp.max"];
    [mapping addAttributeWithProperty:@"tempLow" keyPath:@"temp.min"];
    [mapping addAttributesFromArray:@[@"weather"]];
    
    return mapping;
}

@end
