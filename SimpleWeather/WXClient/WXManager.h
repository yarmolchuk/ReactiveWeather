//
//  WXManager.h
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 08.11.15.
//

@import Foundation;
@import CoreLocation;

#import "WXCondition.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WXManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

+ (instancetype)sharedManager;

- (void)findCurrentLocation;

@end
