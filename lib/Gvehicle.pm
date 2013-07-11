package Gvehicle;
use Mojo::Base 'Mojolicious';
use Gvehicle::Schema;

has schema => sub { 
	return Gvehicle::Schema->connect('dbi:SQLite:busdb') or die "could not connect";
 };

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  
  #helper method to access schema
  $self->helper(db => sub { $self->schema; });

  # Router
  my $r = $self->routes;

 #For Cross Orgin Resource Sharing
  $self->hook(
    before_dispatch => sub {
      my $c = shift;
      $c->res->headers->header('Access-Control-Allow-Origin' => '*');
      $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, OPTIONS, POST, DELETE, PUT');
      $c->res->headers->header('Access-Control-Allow-Headers' => 'content-type' );
    });


  # Normal route to controller

  $r->get('/')->to('index#index');

  #Route to vehicle screens
  $r->get('/vehicle')->to('vehiclescreen#vehicle');
  $r->get('/register')->to('vehicle#register');
  $r->get('/vstatus')->to('vstatusscreen#vstatus');
  $r->get('/:vid/register')->to('vehicle#register');
  $r->get('/update/:vid/*lat/*lon/:utime')->to('vehicle#update');
  $r->post('/update')->to('vehicle#update');
  $r->get('/terminate')->to('registerscreen#vregister');

  # Route to user screens
  $r->get('/user')->to('userscreen#user');
  $r->get('/:src/:dst/findroute')->to('vehicle#routefinder');
  $r->get('/findroute')->to('vehicle#routefinder');
  $r->get('/route')->to('vehicle#route');
  $r->get('/route/:id/:bno/:route')->to('vehicle#route');
  $r->get('/route/:id')->to('vehicle#route');
}

1;
