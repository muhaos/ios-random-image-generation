//
//  KRViewController.m
//  ImageGenerator
//
//  Created by Vova Musiienko on 26.08.14.
//  Copyright (c) 2014 pulsarfour.com. All rights reserved.
//

#import "KRViewController.h"

@interface KRViewController ()

@end

@implementation KRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

static int iterations = 0;

- (IBAction) doIt
{

    CGSize newSize = CGSizeMake(2000, 1600);
    UIGraphicsBeginImageContext(newSize);

    iterations = 0;
    
    [self makeImage];
    

}


- (void) image: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo
{
    if (error) {
        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }

    [self makeImage];
}


- (void) makeImage
{
    
    dispatch_async(dispatch_get_main_queue(), ^{

        int count = [self.countField.text intValue];
        
        self.progressView.progress = iterations / (float)count;

        
        if (iterations >=  count) {
            [[[UIAlertView alloc] initWithTitle:nil message:@"DONE" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            return;
        }
        
        [[UIColor colorWithRed:(rand() % 100) / 100.0f green:(rand() % 100) / 100.0f blue:(rand() % 100) / 100.0f alpha:1.0f] setFill];
        
        CGRect r = CGRectMake(0, 0, 3000, 2000);
        
        UIRectFill(r);
        
        NSString* asd = [NSString stringWithFormat:@"%i", iterations];

        NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:500],
                                 NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
        
        
        [asd drawInRect:CGRectInset(r, 500, 350) withAttributes:attrs];
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        UIImageWriteToSavedPhotosAlbum(finalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

        iterations ++;
    });
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
