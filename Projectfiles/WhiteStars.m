//
//  WhiteStars.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import "WhiteStars.h"

CCDirector *director;

@implementation WhiteStars


-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"whiteStar.png"];//load star from file
    
    self.sprite.position = CGPointMake(arc4random() % (int)director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height);
    
    self.sprite.scale = 0.02f;
    //self.speed = -10;
    self.speed = arc4random() % 10 - 15;
    NSLog(@"speed: %d", self.speed);
    return self;
}

-(void) update{
    if (self.sprite.position.x < 0){
        [self reset];
    }
    
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}

-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height);
}

@end
