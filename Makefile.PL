use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Getopt::Attribute',
    'VERSION_FROM'	=> 'Attribute.pm', # finds $VERSION
    'PREREQ_PM'		=> {
    	Getopt::Long => 0,
	Attribute::Handlers => '0.70',
    },
    dist                => {
        # don't ask about existing .tar.gz files
        COMPRESS => 'gzip --force --best'
    },
);
