//
//  WXMappingProvider+WXCondition.m
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 09.11.15.
//

#import "WXMappingProvider+WXCondition.h"
#import "WXCondition.h"

@implementation WXMappingProvider (WXCondition)

+ (FEMMapping *)conditionMapping {
    
    
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[WXCondition class]];
    [mapping addAttributeWithProperty:@"date" keyPath:@"dt"];
    [mapping addAttributeWithProperty:@"locationName" keyPath:@"name"];
    [mapping addAttributeWithProperty:@"humidity" keyPath:@"main.humidity"];
    [mapping addAttributeWithProperty:@"temperature" keyPath:@"main.temp"];
    [mapping addAttributeWithProperty:@"tempHigh" keyPath:@"main.temp_max"];
    [mapping addAttributeWithProperty:@"tempLow" keyPath:@"main.temp_min"];
    [mapping addAttributeWithProperty:@"sunrise" keyPath:@"sys.sunrise"];
    [mapping addAttributeWithProperty:@"sunset" keyPath:@"sys.sunset"];
    [mapping addAttributeWithProperty:@"conditionDescription" keyPath:@"weather.description"];
    
    [mapping addAttributesFromArray:@[@"weather"]];
    [mapping addAttributeWithProperty:@"windBearing" keyPath:@"wind.deg"];
    [mapping addAttributeWithProperty:@"windSpeed" keyPath:@"wind.speed"];
        
    return mapping;
}

@end
