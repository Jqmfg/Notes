#!/usr/bin/perl
#use warnings;
use Path::Tiny qw(path);

#Importing the file
my $filename = 'IntroToLinux.md';
my $file = path($filename);
my $data = $file ->slurp_utf8;

#Placing code blocks into an array and replacing them in the file
my @code_block_values;

while($data =~ s/(\n\t*```.*?```\n)/(code_block)/xs) {
	push @code_block_values, $1;
}

#All the replacing stuff goes here
$data =~ s/\n\n\n/\n\n/g;
$data =~ s/\n\n/(double_line)/g;
$data =~ s/\n___/(line_break)/g;
$data =~ s/\n        /(line_quad_tab)/g;
$data =~ s/\n      /(line_triple_tab)/g;
$data =~ s/\n    /(line_double_tab)/g;
$data =~ s/\n  /(line_single_tab)/g;
$data =~ s/  / /g;
$data =~ s/\n```/(line_code_block)/g;
$data =~ s/ \n/ /g;
$data =~ s/\n/ /g;
$data =~ s/\(line_code_block\)/\n```/g;
$data =~ s/\(line_single_tab\)/\n  /g;
$data =~ s/\(line_double_tab\)/\n    /g;
$data =~ s/\(line_triple_tab\)/\n      /g;
$data =~ s/\(line_quad_tab\)/\n        /g;
$data =~ s/\(line_break\)/\n___/g;
$data =~ s/\(double_line\)/\n\n/g;

#Fixing the h1 formatting
$data =~ s/#/\n#/g;

#Replacing code_blocks
$data =~ s/\(code_block\)/ shift @code_block_values/xge;

#Writing to the file again
$file->spew_utf8( $data );
