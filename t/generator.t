use Compile::Generators;

use Test::More tests => 3;

sub bogus1 {
    return 42;
}

sub gen_range :generator {
    my ($min, $max) = @_;
    my $num = $min;
    my $incr;

    while (not defined $max or $num < $max) {
        $incr = shift(@_) || 1;
        yield $num;
        $num += $incr;
    }
}

my $range = gen_range(50, 100);
my $incr = gen_range(1);

my @numbers;
while (my $num = $range->($incr->())) {
    push @numbers, $num;
}

sub bogus2 {
    return 42;
}

is(join('-', @numbers), '50-51-53-56-60-65-71-78-86-95', "generator works");

ok ((-f 't/generator.tc'), "Compiled file exists");
pass __FILE__;

