//
//  WXClient.h
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 08.11.15.
//

@import CoreLocation;
@import Foundation;

@class RACSignal;

@interface WXClient : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;
- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate;

@end
