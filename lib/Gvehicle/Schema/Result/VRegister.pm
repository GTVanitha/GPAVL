use utf8;
package Gvehicle::Schema::Result::VRegister;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gvehicle::Schema::Result::VRegister

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

=head1 TABLE: C<v_register>

=cut

__PACKAGE__->table("v_register");

=head1 ACCESSORS

=head2 v_id

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("v_id", { data_type => "text", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</v_id>

=back

=cut

__PACKAGE__->set_primary_key("v_id");

=head1 RELATIONS

=head2 stops_infos

Type: has_many

Related object: L<Gvehicle::Schema::Result::StopsInfo>

=cut

__PACKAGE__->has_many(
  "stops_infos",
  "Gvehicle::Schema::Result::StopsInfo",
  { "foreign.dup_rno" => "self.v_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 v_location

Type: might_have

Related object: L<Gvehicle::Schema::Result::VLocation>

=cut

__PACKAGE__->might_have(
  "v_location",
  "Gvehicle::Schema::Result::VLocation",
  { "foreign.v_id" => "self.v_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-05-05 12:36:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hFiqyYX9sTyyzfjcrACQdA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
