//
//  WXClient.m
//  SimpleWeather
//
//  Created by Dima Yarmolchuk on 08.11.15.
//

#import "WXClient.h"
#import "WXCondition.h"
#import "WXDailyForecast.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "WXMappingProvider+WXCondition.h"
#import "WXMappingProvider+WXDailyForecast.h"

#define APIKEY                              @"c80333cbc809bb63248f0c723aeb9d4b"

@interface WXClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation WXClient

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate {
    if (!coordinate.latitude || !coordinate.longitude) {
        coordinate.latitude = 50.27;
        coordinate.longitude = 30.30;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial&APPID=%@", coordinate.latitude, coordinate.longitude, APIKEY];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [FEMDeserializer objectFromRepresentation:json mapping:[WXMappingProvider conditionMapping]];
    }];
}

- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    if (!coordinate.latitude || !coordinate.longitude) {
        coordinate.latitude = 50.27;
        coordinate.longitude = 30.30;
    }

    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&units=imperial&cnt=12&APPID=%@", coordinate.latitude, coordinate.longitude, APIKEY];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        RACSequence *list = [json[@"list"] rac_sequence];
        
        return [[list map:^(NSDictionary *item) {
            return [FEMDeserializer objectFromRepresentation:item mapping:[WXMappingProvider conditionMapping]];
        }] array];
    }];
}

- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    if (!coordinate.latitude || !coordinate.longitude) {
        coordinate.latitude = 50.27;
        coordinate.longitude = 30.30;
    }

    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&units=imperial&cnt=7&APPID=%@", coordinate.latitude, coordinate.longitude, APIKEY];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Use the generic fetch method and map results to convert into an array of Mantle objects
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        // Build a sequence from the list of raw JSON
        RACSequence *list = [json[@"list"] rac_sequence];
        
        // Use a function to map results from JSON to Mantle objects
        return [[list map:^(NSDictionary *item) {
            return [FEMDeserializer objectFromRepresentation:item mapping:[WXMappingProvider dailyForecastMapping]];
        }] array];
    }];
}

@end
