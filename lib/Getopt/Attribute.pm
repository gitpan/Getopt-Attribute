package Getopt::Attribute;

use Getopt::Long;
use Attribute::Handlers;

our $VERSION = '1.41';

sub UNIVERSAL::Getopt : ATTR(RAWDATA,BEGIN) {
	my ($ref, $data) = @_[2,4];
	our %options;
    # this has to be an array as we're chasing refs later
    if ($data =~ m/^(\S+)\s+(.*)/) {    
        $data = $1;
        push our @defaults, [ $ref => $2 ];
    }
	$options{$data} = $ref;
}

INIT {
    GetOptions(our %options);
    defined ${$_->[0]} or ${$_->[0]} = $_->[1] for our @defaults;
}

sub options { our %options }

1;

__END__

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

Alternatively, you can specify a default value within the Getopt
attribute:

    our $def2 : Getopt(def2=i 42);

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-getopt-attribute@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2001-2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

