//
//  Asteroid.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import "Asteroid.h"

CCDirector *director;
const int Slow = 0;
const int Fast = 1;
const int Normal = 2;
int speedByPace[] = { -2, -8, -4 };
int pace = Normal;


@implementation Asteroid


-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"asteroid.png"];//load asteroid from file
    self.sprite.position = CGPointMake(arc4random() % (int)director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
    self.sprite.scale = 0.25f;
    [self setSpeedByPace];
    return self;
}

CCSprite *explosion;
CCSprite *dust;
int explosionCounter = 0;

-(void) update{
    if (self.sprite.position.x < 0){
        [self reset];
    }
    
 //  NSLog(@"Asteroid speed: %d", [self getSpeed]);
    
    if(CGRectIntersectsRect([self.sprite boundingBox], [self.ship boundingBox])){
        if(explosion != nil)
            [self.layer removeChild:explosion];
        explosion = [CCSprite spriteWithFile:@"explosion.png"];
        explosion.position = self.sprite.position;
        explosion.scale = 0.5;
        explosionCounter = 0;
        [self.layer addChild:explosion];
        [self reset];
    }
    
    if(explosionCounter++ > 10){
        [self.layer removeChild:explosion];
        explosion = nil;
    }
    
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}
-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
}

-(void) setSpeedByPace {
    self.speed = speedByPace[pace];
}

-(void) replay{
    [self setSpeedByPace];
   // NSLog(@"Asteroid speed: %d", [self getSpeed]);
    
}

-(void) pause{
    self.speed = 0;
}

-(void) slowDown{
    pace = Slow;
    [self setSpeedByPace];
     NSLog(@"asteroid slowed");
     //NSLog(@"speed: %d", self.speed);
}

-(void) speedUp{
    pace = Fast;
    [self setSpeedByPace];
}

-(void) goToNormal{
    pace = Normal;
    [self setSpeedByPace];
    NSLog(@"Asteroid normalized");
}

-(int) getSpeed{
    return self.speed;
}

-(void) removeExplosion{
    [self.layer removeChild:explosion];
    
}
@end
