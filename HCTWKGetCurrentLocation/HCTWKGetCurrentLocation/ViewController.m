//
//  ViewController.m
//  HCTWKLocation
//
//  Created by Ha Cong Thuan on 5/19/15.
//  Copyright (c) 2015 Ha Cong Thuan. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    float lat;
    float lon;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getlocation];
}
-(void)getlocation{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
    lat = locationManager.location.coordinate.latitude;
    lon = locationManager.location.coordinate.longitude;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager  didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    lat = newLocation.coordinate.latitude;
    lon = newLocation.coordinate.longitude;

    NSLog(@" Current Latitude : %f",lat);

    NSLog(@" Current Longitude : %f",lon);
}
@end
