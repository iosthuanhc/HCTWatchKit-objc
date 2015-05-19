//
//  InterfaceController.m
//  HCTWKLocation WatchKit Extension
//
//  Created by Ha Cong Thuan on 5/19/15.
//  Copyright (c) 2015 Ha Cong Thuan. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapview;
@property (nonatomic) MKCoordinateRegion currentRegion;
@property (nonatomic) MKCoordinateSpan  currentSpan;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
     _currentSpan = MKCoordinateSpanMake(0.003f, 0.003f);
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [WKInterfaceController openParentApplication:@{@"HCTWKSendAction" : @"getlocation"} reply:^(NSDictionary *replyInfo, NSError *error) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[replyInfo objectForKey:@"lat"] floatValue],[[replyInfo objectForKey:@"lon"] floatValue]);
        [_mapview removeAllAnnotations];
        [self goToLocation:coordinate];
    }];
}
-(void)goToLocation:(CLLocationCoordinate2D )coordinate{
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, _currentSpan);
    
    [_mapview setRegion:region];
    [_mapview addAnnotation:coordinate withPinColor:WKInterfaceMapPinColorRed];
    

}
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (void)removeAll {
    [_mapview removeAllAnnotations];
}

@end



