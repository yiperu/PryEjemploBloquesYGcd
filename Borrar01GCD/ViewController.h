//
//  ViewController.h
//  Borrar01GCD
//
//  Created by Henry AT on 9/18/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)btnPrueba01:(id)sender;

//typedef void (^MiTipoBloque)(int);


@property (weak, nonatomic) IBOutlet UIImageView *uiimageview1;

- (IBAction)btnPrimerPlano:(id)sender;
- (IBAction)btnSegundoPlano:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uiactivityIndicator;


- (IBAction)btnSerie:(id)sender;

- (IBAction)btnConcurrente:(id)sender;

@end
