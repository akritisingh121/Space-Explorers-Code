//
//  Asteroid.h
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"


@interface Asteroid : NSObject


@property CCSprite *sprite;
@property CCSprite *ship;
@property CCSprite *bullet;
@property int speed;
@property HelloWorldLayer *layer;

-(void) update;

-(void) reset;

-(void) pause;

-(void) replay;

-(void) slowDown;

-(void) goToNormal;

-(void) speedUp;

-(void) setSpeedByPace;

-(void) removeExplosion;


@end
