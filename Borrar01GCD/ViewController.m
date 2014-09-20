//
//  ViewController.m
//  Borrar01GCD
//
//  Created by Henry AT on 9/18/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

typedef void (^MiTipoBloque)(int);

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPrueba01:(id)sender {
    
    // Creamos nuestra instancia del tipo definido arriba
    MiTipoBloque mibloque;
    
    // Creamos una variable numerica con la directiva __block que hace
    // que podamos modificar su valor desde el interior del bloque
    // siendo nosotros los responsables de lo que pudiera ocurrir.
    // En caso de no indicar __block nos saltaría un error en XCode
    // impidiendo modificar total desde dentro del bloque.
    __block int total = 0;
    
    // Rellenamos el bloque con código
    mibloque = ^ void (int valor) {
        total += valor;
        NSLog(@"Total: %d",total);
    };
    
    // Ejecutamos varias veces el bloque para comprobar
    mibloque(1);
    mibloque(1);
    mibloque(1);

}





- (IBAction)btnPrimerPlano:(id)sender {
    
    // Creamos la URL para nuestra imagen
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.deshow.net/d/file/travel/2009-06/brazil-landscape-580-2.jpg"];
     
     // Obtenemos los datos de la imagen (esto tardara un poco al tratarse
     // de una imagen de alta resolución)
     NSData *dataImagen = [NSData dataWithContentsOfURL:url];
     
     // Creamos un UIImage con los datos obtenidos
     UIImage *imagen = [[UIImage alloc] initWithData:dataImagen];
     
     // Asignamos al UIImageView de nuestra vista dicho UIImage
     self.uiimageview1.image = imagen;
     
     
}

- (IBAction)btnSegundoPlano:(id)sender {
    // Creamos la URL para nuestra imagen
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.deshow.net/d/file/travel/2009-06/brazil-landscape-580-2.jpg"];
    
    [self.uiactivityIndicator startAnimating];
     // Obtenemos la cola de segundo plano
    // Creamos una variable de tipo: dispatch_queue_t
     dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     
     // Invocamos en modo asíncrono un bloque en la cola que hemos recuperado
     dispatch_async(backgroundQueue, ^{
        
        // Obtenemos los datos de la imagen (esto tardara un poco al
        // tratarse de una imagen de alta resolución)
        NSData *dataImagen = [NSData dataWithContentsOfURL:url];
        
        // Creamos un UIImage con los datos obtenidos
        UIImage *imagen = [[UIImage alloc] initWithData:dataImagen];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Asignamos al UIImageView de nuestra vista dicho UIImage
            self.uiimageview1.image = imagen;
            [self.uiactivityIndicator stopAnimating];
        });
        
    });
 
     
}
- (IBAction)btnSerie:(id)sender {
    
    dispatch_queue_t colaEnSerie = dispatch_queue_create("miColaEnSerie", NULL);
    
    dispatch_async(colaEnSerie, ^{
        NSLog(@"Entra en la tarea 1");
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"Sale de la tarea 1");
    });
    
    dispatch_async(colaEnSerie, ^{
        NSLog(@"Entra en la tarea 2");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"Sale de la tarea 2");
    });
    
}

- (IBAction)btnConcurrente:(id)sender {
    
    dispatch_queue_t colaConcurrente = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(colaConcurrente, ^{
        NSLog(@"Entra en la tarea 1");
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"Sale de la tarea 1");
    });
    
    dispatch_async(colaConcurrente, ^{
        NSLog(@"Entra en la tarea 2");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"Sale de la tarea 2");
    });
    
}




@end
