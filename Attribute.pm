package Getopt::Attribute;

# $Id: Attribute.pm,v 1.3 2002/07/17 21:48:50 marcelgr Exp $
#
# $Log: Attribute.pm,v $
# Revision 1.3  2002/07/17 21:48:50  marcelgr
# added version warning to pod
#
# Revision 1.2  2002/07/17 21:10:56  marcelgr
# updated for perl 5.8.0
#
# Revision 1.1.1.1  2002/06/13 07:17:54  marcelgr
# initial import
#

require 5.008;
use Getopt::Long;
use Attribute::Handlers;

(our $VERSION) = '$Revision: 1.3 $' =~ /([\d.]+)/;

sub UNIVERSAL::Getopt : ATTR(RAWDATA,BEGIN) {
	my ($ref, $data) = @_[2,4];

	our %options;
	$options{$data} = $ref;
}

INIT { GetOptions(our %options) }

sub options { our %options }

1;

__END__

=for prereqs
Getopt::Long
Attribute::Handlers 0.70
Test::More 0.42

=for makepmdist-tests
use strict;
use Test::More tests => 9;
use Getopt::Attribute;
BEGIN {
	@ARGV = qw(--noverbose --all --size=23 --more --more --more --quiet
	    --library lib/stdlib --library lib/extlib
	    --define os=linux --define vendor=redhat --man -- --more)
}
our $verbose : Getopt(verbose!);
is($verbose, 0, 'turned-off boolean option');
our $all     : Getopt(all);
is($all, 1, 'turned-on boolean option');
our $size    : Getopt(size=s);
is($size, 23, 'string option');
our $more    : Getopt(more+);
is($more, 3, 'flag given several times');
our @library : Getopt(library=s);
our $library = join ':' => @library;
is($library, 'lib/stdlib:lib/extlib', 'array option');
our %defines : Getopt(define=s);
our $defines = join ', ' => map "$_ => $defines{$_}" => keys %defines;
ok(keys(%defines) == 2 &&
    $defines{os} eq 'linux' && $defines{vendor} eq 'redhat', 'hash option');
sub quiet : Getopt(quiet) { our $quiet_msg = 'seen quiet' }
is(our $quiet_msg, 'seen quiet', 'option with code handler');
usage() if our $man : Getopt(man);
sub usage { our $man_msg = 'seen man' }
is(our $man_msg, 'seen man', 'another option with code handler');
ok(length(@ARGV) == 1 && $ARGV[0] eq '--more', 'non-option option-look-a-like');

=head1 NAME

Getopt::Attribute - Attribute wrapper for Getopt::Long

=head1 SYNOPSIS

  use Getopt::Attribute;

  our $verbose : Getopt(verbose!);
  our $all     : Getopt(all);
  our $size    : Getopt(size=s);
  our $more    : Getopt(more+);
  our @library : Getopt(library=s);
  our %defines : Getopt(define=s);
  sub quiet : Getopt(quiet) { our $quiet_msg = 'seen quiet' }
  usage() if our $man : Getopt(man);
  ...

  # Meanwhile, on some command line:

  mypgm.pl --noverbose --all --size=23 --more --more --more --quiet
           --library lib/stdlib --library lib/extlib
           --define os=linux --define vendor=redhat --man -- foo

=head1 DESCRIPTION

Note: This version of the module works works with perl 5.8.0. If you
need it to work with perl 5.6.x, please use an earlier version from CPAN.

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

	our $verbose : Getopt(verbose!) = 1;  # DOES NOT WORK

Instead, you have to establish defaults afterwards, like so:

	our $verbose : Getopt(verbose!);
	$verbose ||= 1;

=head1 BUGS

None known so far. If you find any bugs or oddities, please do inform the
author.

=head1 AUTHOR

Marcel GrE<uuml>nauer <marcel.gruenauer@chello.at>

=head1 COPYRIGHT

Copyright 2001 Marcel GrE<uuml>nauer. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), Getopt::Long(3pm), Attribute::Handlers(3pm).

=cut
