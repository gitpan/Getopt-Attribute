use inc::Module::Install;
name 'Getopt-Attribute';
all_from 'lib/Getopt/Attribute.pm';
perl_version '5.008';

build_requires 'Test::More';

use_test_base;
auto_include;
WriteAll;
