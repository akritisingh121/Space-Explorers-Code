//
//  WhiteStars.h
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface WhiteStars : NSObject

@property CCSprite *sprite;
@property int speed;
@property HelloWorldLayer *layer;

-(void) update;

-(void) reset;



@end
