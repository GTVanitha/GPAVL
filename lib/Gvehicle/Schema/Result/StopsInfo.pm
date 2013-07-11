use utf8;
package Gvehicle::Schema::Result::StopsInfo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gvehicle::Schema::Result::StopsInfo

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<stops_info>

=cut

__PACKAGE__->table("stops_info");

=head1 ACCESSORS

=head2 stop_no

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 stop_nam

  data_type: 'text'
  is_nullable: 1

=head2 dup_rno

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 1

=head2 rno

  data_type: 'text'
  is_nullable: 1
=head2 route
 
 data_type: 'text'
 is_nullable:1

=head2 line
 
 data_type: 'text'
 is_nullable:1

=cut

__PACKAGE__->add_columns(
  "stop_no",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "stop_nam",
  { data_type => "text", is_nullable => 1 },
  "dup_rno",
  { data_type => "text", is_foreign_key => 1, is_nullable => 1 },
  "rno",
  { data_type => "text", is_nullable => 1 },
   "route",
  { data_type => "text", is_nullable => 1 },
  "line",
  { data_type => "text", is_nullable => 1 },

);

=head1 PRIMARY KEY

=over 4

=item * L</stop_no>

=back

=cut

__PACKAGE__->set_primary_key("stop_no");

=head1 RELATIONS

=head2 dup_rno

Type: belongs_to

Related object: L<Gvehicle::Schema::Result::VRegister>

=cut

__PACKAGE__->belongs_to(
  "v_locations",
  "Gvehicle::Schema::Result::VRegister",
  { v_id => "dup_rno" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-05-05 12:36:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QXRWBn8F069e37c70ki2Ww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
