//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSMutableArray *midias;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
   UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
   [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
      [iTunesManager sharedInstance];
   
     [self.search setDelegate:self];
    self.search.placeholder =  NSLocalizedString(@"pesquisar", nil);
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *asMidias = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:asMidias.nome];
    [celula.tipo setText:asMidias.midia];
    [celula.genero setText:asMidias.genero];
    [celula.duracao setText:[NSString stringWithFormat:@"%@",asMidias.duracao]];
    
    
    
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [[NSMutableArray alloc] init];
//    NSArray *movie = [itunes buscarMidias:(_search.text) andMedia:@"movie"];
//    NSArray *ebook = [itunes buscarMidias:(_search.text) andMedia:@"ebook"];
//    NSArray *podcast = [itunes buscarMidias:(_search.text) andMedia: @"podcast" ];
//    NSArray *music = [itunes buscarMidias:(_search.text) andMedia:@"music"];
    [midias addObjectsFromArray:[itunes buscarMidias:(_search.text) andMedia:@"movie"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(_search.text) andMedia:@"ebook"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(_search.text) andMedia: @"podcast" ]];
    [midias addObjectsFromArray:[itunes buscarMidias:(_search.text) andMedia:@"music"]];
    
    
    [self.search resignFirstResponder];
    [self.tableview reloadData];

}
@end
