# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..10\n"; }
END {print "not ok 1\n" unless $loaded;}
use Getopt::Attribute;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

BEGIN {
	@ARGV = qw(--noverbose --all --size=23 --more --more --more --quiet
	    --library lib/stdlib --library lib/extlib
	    --define os=linux --define vendor=redhat --man -- --more)
}

my $verbose : Getopt(verbose!);
print 'not ' unless $verbose == 0;
print "ok 2\n";

my $all     : Getopt(all);
print 'not ' unless $all == 1;
print "ok 3\n";

my $size    : Getopt(size=s);
print 'not ' unless $size == 23;
print "ok 4\n";

my $more    : Getopt(more+);
print 'not ' unless $more == 3;
print "ok 5\n";


my @library : Getopt(library=s);
my $library = join ':' => @library;
print 'not ' unless $library eq 'lib/stdlib:lib/extlib';
print "ok 6\n";

my %defines : Getopt(define=s);
my $defines = join ', ' => map "$_ => $defines{$_}" => keys %defines;
print 'not ' unless $defines eq 'os => linux, vendor => redhat';
print "ok 7\n";

sub quiet : Getopt(quiet) { our $quiet_msg = 'seen quiet' }
print 'not ' unless our $quiet_msg eq 'seen quiet';
print "ok 8\n";

usage() if my $man : Getopt(man);
sub usage { our $man_msg = 'seen man' }
print 'not ' unless our $man_msg eq 'seen man';
print "ok 9\n";

print 'not ' unless length(@ARGV) == 1 && $ARGV[0] eq '--more';
print "ok 10\n";

__END__

# For debugging purposes:

print <<EOT;
verbose = <$verbose>
all     = <$all>
size    = <$size>
more    = <$more>
library = <@library>
defines = <$defines>
EOT

