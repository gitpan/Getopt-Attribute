package Getopt::Attribute;

use Getopt::Long;
use Attribute::Handlers;

our $VERSION = '0.02';

sub UNIVERSAL::Getopt : ATTR(RAWDATA) {
	my ($ref, $data) = @_[2,4];

	our %options;
	$options{$data} = $ref;
}

INIT { GetOptions(our %options) }

sub options { our %options }

1;

__END__

=head1 NAME

Getopt::Attribute - Attribute wrapper for Getopt::Long

=head1 SYNOPSIS

  use Getopt::Attribute;

  my $verbose : Getopt(verbose!);
  my $all     : Getopt(all);
  my $size    : Getopt(size=s);
  my $more    : Getopt(more+);
  my @library : Getopt(library=s);
  my %defines : Getopt(define=s);
  sub quiet : Getopt(quiet) { our $quiet_msg = 'seen quiet' }
  usage() if my $man : Getopt(man);
  ...

  # Meanwhile, on some command line:

  mypgm.pl --noverbose --all --size=23 --more --more --more --quiet
           --library lib/stdlib --library lib/extlib
           --define os=linux --define vendor=redhat --man -- foo

=head1 DESCRIPTION

This module provides an attribute wrapper around C<Getopt::Long>.
Instead of declaring the options in a hash with references to the
variables and subroutines affected by the options, you can use the
C<Getopt> attribute on the variables and subroutines directly.

As you can see from the Synopsis, the attribute takes an argument
of the same format as you would give as the hash key for C<Getopt::Long>.
See the C<Getopt::Long> manpage for details.

Note that since attributes are processed during CHECK, but assignments
on newly declared variables are processed during run-time, you
can't set defaults on those variables beforehand, like this:

	my $verbose : Getopt(verbose!) = 1;  # DOES NOT WORK

Instead, you have to establish defaults afterwards, like so:

	my $verbose : Getopt(verbose!);
	$verbose ||= 1;

=head1 BUGS

None known so far. If you find any bugs or oddities, please do inform the
author.

=head1 AUTHOR

Marcel Grunauer, <marcel@codewerk.com>

=head1 COPYRIGHT

Copyright 2001 Marcel Grunauer. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), Getopt::Long(3pm), Attribute::Handlers(3pm).

=cut
