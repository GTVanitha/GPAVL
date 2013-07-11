package Gvehicle::Vehicle;
use Mojo::Base 'Mojolicious::Controller';
use Gvehicle::Schema;

=head1 NAME

Gvehicle::Vehicle

=cut

=head1 ACTIONS 

=head1 register

=head2 DESCRIPTION

 To register the vehicle with an unique number

=head2 USAGE

 /vid/register

 - vid : Unique Vehicle ID

=cut

sub register {
	my $self = shift;

	my $id = $self->param('vid');
	if(!$id) {
		return $self->render(json => {status => "error", message =>"id is empty"});
	}

	my $vid = $self->db->resultset('VRegister')->find($id);

	if($vid) {
		return $self->render(json => {status => "error", message => "already registered"});
	}

	eval{ $self->db->resultset('VRegister')->create( {v_id => $id});
	 	$self->db->resultset('VLocation')->create( { v_id => $id,lat => 0.0,lon => 0.0, u_time => 1367524696529}); };
	if($@){
		return $self->render(json => {status => "error", message => "NOT successfully registered"});
	}
	return $self->render(json => {status => "ok", message => "successfully registered"});
}

=head1 update

=head2 DESCRIPTION

 To update the Vehicle Information into the database

=head2 USAGE
 
 /vid/lat/lon/utime/update

 - vid : Already registered Vehicle ID
 - lat : Latitude of vehicle's position
 - lon : Longitude of vehicle's position
 - utime : Time of the getting the vehicle's location
 
=cut

sub update{
	my $self = shift;
	my $id = $self->param('vid');
	my $lat = $self->param('lat');
	my $lon = $self->param('lon');
	my $utime = $self->param('utime');

	my $vid = $self->db->resultset('VLocation')->find($id);
	if(!$vid){
		say "error in update";
		$self->render(json => {status => "error", message=>"no vehicle found"});
		return;
	}

	eval { $vid -> update( { v_id => $id, lat => $lat, lon => $lon, u_time => $utime }); };
	if ($@) {
		$self->render(json => { status => "error", message => "error in update"});
	}
	else {
		$self->render(json => {status => "ok", message => "Successfully updated"});
	}
	
}

=head1 routefinder

=head2 DESCRIPTION
 
 To find the Bus Numbers with routes for corresponding Source and Destination

=head2 USAGE
 
 /src/dst/findroute

 -src : Source location of the user
 -dst : Destination location of the user
=cut

sub routefinder {
        my $self = shift;
        my @srcarr=[];
        my @dstarr=[];
        my $src = $self->param('src');
        my $dst = $self->param('dst');
        
	my  @v_src = $self->db->resultset('StopsInfo')->search( {stop_nam=> { like => "$src" } });
        my  @v_dst = $self->db->resultset('StopsInfo')->search( {stop_nam=> { like => "$dst" } });
        if(@v_src || @v_dst) {
                $self->render(json => { status => "ok", srcstop => [ map { {
                                                dupno => $_->dup_rno,
                                                rno => $_->rno,
                                                sname=>$_->stop_nam,
                                                route=>$_->route,
                                                line=>$_->line,
                                        }; } @v_src ],
                                        dststop => [ map { {
                                                dupno => $_->dup_rno,
                                                rno => $_->rno,
                                                sname=>$_->stop_nam,
                                                route=>$_->route,
                                                line=>$_->line,
                                                }; } @v_dst ]
                        });
                        return;
        }
        else {
		 $self->render(json => { status => "error", stops => "null"});
        }
}


=head1 route

=head2 DESCRIPTION

 To get the location information of the unique vehicle from the database

=head2 USAGE

 /route/id

 - id : Vehicle ID that is already registered in database
=cut

sub route {
        my $self = shift;
        my $id = $self->param('id');
        my $rno= $self->param('bno');
        my $routenam = $self->param('route');
        
	my $route = $self->db->resultset('VRegister')->find($id);
        if($route) {
                my @buses = $route->v_location();
                $self->render(json => { status => "ok",	bno => $rno, 
							route => $routenam, 
							markers => [ map { {
									vid => $_->v_id,
				                                        latitude => $_->lat,
                                				        longitude => $_->lon,
				                                        u_time => $_->u_time }; } @buses]
                });
                return;
        }
        else {
                return $self->render(json => { status => "error", vid => "null" });
        }
}

1;
