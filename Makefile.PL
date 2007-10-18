use inc::Module::Install;
name 'Getopt-Attribute';
all_from 'lib/Getopt/Attribute.pm';
perl_version '5.008';

build_requires 'Test::More' => '0.70';

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;
