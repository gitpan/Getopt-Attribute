use inc::Module::Install;
name 'Getopt-Attribute';
all_from 'lib/Getopt/Attribute.pm';

build_requires 'Test::More';

use_test_base;
auto_include;
WriteAll;
