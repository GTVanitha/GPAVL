use utf8;
package Gvehicle::Schema::Result::VLocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gvehicle::Schema::Result::VLocation

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

=head1 TABLE: C<v_locations>

=cut

__PACKAGE__->table("v_locations");

=head1 ACCESSORS

=head2 v_id

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 lat

  data_type: 'real'
  is_nullable: 1

=head2 lon

  data_type: 'real'
  is_nullable: 1

=head2 u_time

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "v_id",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "lat",
  { data_type => "real", is_nullable => 1 },
  "lon",
  { data_type => "real", is_nullable => 1 },
  "u_time",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</v_id>

=back

=cut

__PACKAGE__->set_primary_key("v_id");

=head1 RELATIONS

=head2 v

Type: belongs_to

Related object: L<Gvehicle::Schema::Result::VRegister>

=cut

__PACKAGE__->belongs_to(
  "v_register",
  "Gvehicle::Schema::Result::VRegister",
  { v_id => "v_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-05-05 12:36:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:U98hsi8C7SkwjZE8AKL5bA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
