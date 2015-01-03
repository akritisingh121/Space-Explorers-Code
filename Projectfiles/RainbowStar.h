//
//  RainbowStar.h
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface RainbowStar : NSObject


@property CCSprite *sprite;
@property CCSprite *ship;
@property CCSprite *asteroid;
@property int speed;
@property HelloWorldLayer *layer;

-(void) update;

-(void) reset;

-(void) pause;

-(void) replay;

@end
