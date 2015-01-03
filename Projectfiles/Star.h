//
//  Star.h
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Star : NSObject

@property CCSprite *sprite;
@property CCSprite *ship;
@property int speed;
@property HelloWorldLayer *layer;

-(void) update;

-(void) reset;

-(void) pause;

-(void) replay;
@end
