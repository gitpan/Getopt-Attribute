require 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Getopt::Attribute',
  VERSION_FROM => 'Attribute.pm',
  dist         => { COMPRESS => 'gzip -6f', SUFFIX => 'gz', },
  PREREQ_PM    => {
    Getopt::Long        =>  0,
    Attribute::Handlers => 0.70,
    Test::More          => 0.42,
  },
);
