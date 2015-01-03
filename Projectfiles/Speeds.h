//
//  Speeds.h
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/27/14.
//
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Speeds : NSObject

@property CCSprite *sprite;
@property int speed;
@property CCSprite *ship;
@property HelloWorldLayer *layer;

-(void) update;

-(void) reset;

-(void) replay;

-(void) pause;

@end
